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

# Clear existing movies
Movie.destroy_all

ratings = ["G", "PG", "PG-13", "R", "NC-17"]

movies_data = [
  { title: "The Lion King", rating: "G", description: "Animated classic", release_date: "1994-06-24" },
  { title: "Toy Story", rating: "G", description: "Animated adventure", release_date: "1995-11-22" },
  { title: "Finding Nemo", rating: "PG", description: "Animated adventure", release_date: "2003-05-30" },
  { title: "Jurassic Park", rating: "PG-13", description: "Dinosaurs and action", release_date: "1993-06-11" },
  { title: "The Avengers", rating: "PG-13", description: "Superheroes assemble", release_date: "2012-05-04" },
  { title: "The Godfather", rating: "R", description: "Mafia classic", release_date: "1972-03-24" },
  { title: "Deadpool", rating: "R", description: "Action comedy", release_date: "2016-02-12" },
  { title: "Showgirls", rating: "NC-17", description: "Adult drama", release_date: "1995-09-22" }
]

movies_data.each { |m| Movie.create!(m) }

puts "Seeded #{Movie.count} movies!"