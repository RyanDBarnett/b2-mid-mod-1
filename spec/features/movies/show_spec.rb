require 'rails_helper'

describe 'As a user' do
  describe "When I visit a movie's show page" do
    before :each do
      @warner = Studio.create!({name: 'Warner Bros'})

      @busters = @warner.movies.create!({title: 'Ghost Busters', creation_year: 1985, genre: 'comedy'})

      @actor_1 = Actor.create!({name: 'Actor 1', age: 30})
      @actor_2 = Actor.create!({name: 'Actor 2', age: 20})
      @actor_3 = Actor.create!({name: 'Actor 3', age: 10})

      MovieActor.create!({actor: @actor_1, movie: @busters})
      MovieActor.create!({actor: @actor_2, movie: @busters})
      MovieActor.create!({actor: @actor_3, movie: @busters})

      visit "/movies/#{@busters.id}"
    end

    it "I see the movie's title, creation year, and genre" do
      expect(page).to have_content(@busters.title)
      expect(page).to have_content(@busters.creation_year)
      expect(page).to have_content(@busters.genre)
    end

    it 'I see a list of all its actors' do
      within "#movie-#{@busters.id}-actor-#{@actor_1.id}" do
        expect(page).to have_content(@actor_1.name)
      end

      within "#movie-#{@busters.id}-actor-#{@actor_2.id}" do
        expect(page).to have_content(@actor_2.name)
      end

      within "#movie-#{@busters.id}-actor-#{@actor_3.id}" do
        expect(page).to have_content(@actor_3.name)
      end
    end

    it 'I see a list of all actors sorted from youngest to oldest' do
      within "#movie-#{@busters.id}-actors" do
        expect(@actor_3.name).to appear_before(@actor_2.name)
        expect(@actor_2.name).to appear_before(@actor_1.name)
      end
    end

    it "I see the average age of all of the movie's actors" do
      within "#movie-#{@busters.id}-actor-average-age" do
        expect(page).to have_content(20)
      end
    end

    it 'I see a form for an actors name' do
      within '#add-actor-form' do
        expect(page).to have_field('actor_name')
      end
    end

    describe "when I fill in the form with an existing actor's name" do
      it "I am redirected back to that movie's show page" do
        @actor_4 = Actor.create!({name: 'Actor 4', age: 5})

        fill_in 'actor_name', with: @actor_4.name

        click_on 'Save Actor'

        expect(current_path).to eq("/movies/#{@busters.id}")
      end
    end
  end
end

# I am redirected back to that movie's show page
# And I see the actor's name listed
# (You do not have to test for a sad path, for example if the id is not an existing actor)
