class Movie < ApplicationRecord
  has_many :movie_actors
  has_many :actors, through: :movie_actors
  belongs_to :studio
end
