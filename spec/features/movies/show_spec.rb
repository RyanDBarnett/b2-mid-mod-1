require 'rails_helper'

describe 'As a user' do
  describe "When I visit a movie's show page" do
    before :each do
      @warner = Studio.create!({name: 'Warner Bros'})

      @busters = @warner.movies.create!({title: 'Ghost Busters', creation_year: 1985, genre: 'comedy'})

      visit "/movies/#{@busters.id}"
    end

    it "I see the movie's title, creation year, and genre" do
      expect(page).to have_content(@busters.title)
      expect(page).to have_content(@busters.creation_year)
      expect(page).to have_content(@busters.genre)
    end
  end
end

# and a list of all its actors from youngest to oldest.
# And I see the average age of all of the movie's actors
