class Movie < ApplicationRecord
  # Returns all ratings actually in the database
  def self.all_ratings
    Movie.distinct.pluck(:rating)
  end

  # Filters movies by selected ratings
  def self.with_ratings(ratings)
    where(rating: ratings)
  end
end