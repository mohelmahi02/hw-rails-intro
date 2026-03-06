class Movie < ApplicationRecord
  # Returns all possible ratings
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end

  # Returns movies filtered by ratings array
  def self.with_ratings(ratings_list)
    if ratings_list.present?
      where(rating: ratings_list)
    else
      all
    end
  end
end