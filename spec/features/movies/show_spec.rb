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
      within "#movie-#{@busters.id}-actors-average-age" do
        expect(page).to have_content(20)
      end
    end
  end
end
