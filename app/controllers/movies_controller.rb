class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

 def index
  @all_ratings = Movie.all_ratings

  # If sort or ratings params present, save to session
  if params[:ratings] || params[:sort_by]
    session[:ratings_to_show] = params[:ratings] ? params[:ratings].keys : Movie.all_ratings
    session[:sort_by] = params[:sort_by] if params[:sort_by]
    @ratings_to_show = session[:ratings_to_show]
    @sort_by = session[:sort_by]
  elsif session[:ratings_to_show] || session[:sort_by]
    # Redirect with session params to make it RESTful
    redirect_to movies_path(
      ratings: session[:ratings_to_show].zip(Array.new(session[:ratings_to_show].length, '1')).to_h,
      sort_by: session[:sort_by]
    ) and return
  else
    @ratings_to_show = Movie.all_ratings
    @sort_by = nil
  end

  @movies = Movie.with_ratings(@ratings_to_show)
  @movies = @movies.order(@sort_by) if @sort_by.present?
end

  def show
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "Movie was successfully deleted."
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
