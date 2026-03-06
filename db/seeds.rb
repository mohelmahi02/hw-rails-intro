# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed the RottenPotatoes DB with some movies.
Movie.destroy_all

Movie.create(title: "The Lion King", rating: "G", release_date: "1994-06-15")
Movie.create(title: "Finding Nemo", rating: "PG", release_date: "2003-05-30")
Movie.create(title: "Jurassic Park", rating: "PG-13", release_date: "1993-06-11")
Movie.create(title: "The Godfather", rating: "R", release_date: "1972-03-24")