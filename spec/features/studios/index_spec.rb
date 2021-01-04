require 'rails_helper'

describe 'As a user' do
  describe 'When I visit the studio index page' do
    before :each do
      @warner = Studio.create!({name: 'Warner Bros'})
      @mgm = Studio.create!({name: 'MGM'})

      @warner.movies.create!({title: 'Ghost Busters', creation_year: 1985, genre: 'comedy'})
      @warner.movies.create!({title: 'Movie 2', creation_year: 1990, genre: 'drama'})

      @mgm.movies.create!({title: 'Movie 3', creation_year: 1995, genre: 'action'})
      @mgm.movies.create!({title: 'Movie 4', creation_year: 2000, genre: 'horror'})

      visit '/studios'
    end

    it 'I see a list of all of the movie studios' do
      expect(page).to have_content(@warner.name)
      expect(page).to have_content(@mgm.name)
    end

    describe 'And underneath each studio' do
      it 'I see the names of all of its movies' do
        within("#studio-#{@warner.id}") do
          expect(page).to have_content(@warner.movies[0].title)
          expect(page).to have_content(@warner.movies[0].creation_year)
          expect(page).to have_content(@warner.movies[0].genre)

          expect(page).to have_content(@warner.movies[1].title)
          expect(page).to have_content(@warner.movies[1].creation_year)
          expect(page).to have_content(@warner.movies[1].genre)
        end

        within("#studio-#{@mgm.id}") do
          expect(page).to have_content(@mgm.movies[0].title)
          expect(page).to have_content(@mgm.movies[0].creation_year)
          expect(page).to have_content(@mgm.movies[0].genre)

          expect(page).to have_content(@mgm.movies[1].title)
          expect(page).to have_content(@mgm.movies[1].creation_year)
          expect(page).to have_content(@mgm.movies[1].genre)
        end
      end
    end
  end
end
