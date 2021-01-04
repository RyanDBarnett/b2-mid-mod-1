class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.sort_by_age
    order(:age)
  end

  def self.average_age
    average(:age)
  end
end
