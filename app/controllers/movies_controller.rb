class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    @all_ratings = Movie.all_ratings
    @ratings_to_show = params[:ratings]&.keys || @all_ratings
    @sort_by = params[:sort_by]

    @movies = Movie.with_ratings(@ratings_to_show)
    @movies = @movies.order(@sort_by) if @sort_by.present?
  end

  # Other RESTful actions (show, new, edit, create, update, destroy) remain unchanged
  # ...
  
  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end