class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
 def index
  @all_ratings = Movie.all_ratings

  # ---- Determine ratings to show ----
  if params[:ratings]
    # User explicitly selected ratings -> save to session
    @ratings_to_show = params[:ratings].keys
    session[:ratings] = params[:ratings]
  elsif session[:ratings]
    # No params, but session has previous ratings -> use them
    @ratings_to_show = session[:ratings].keys
  else
    # No params and no session -> show all
    @ratings_to_show = @all_ratings
  end

  # ---- Determine sort column ----
  if params[:sort_by]
    # User explicitly selected sort -> save to session
    @sort_by = params[:sort_by]
    session[:sort_by] = @sort_by
  elsif session[:sort_by]
    # No params, but session has previous sort -> use it
    @sort_by = session[:sort_by]
  else
    # Default sort (optional, could be nil)
    @sort_by = nil
  end

  #  Fetch movies 
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