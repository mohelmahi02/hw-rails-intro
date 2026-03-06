class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  def index
  @all_ratings = Movie.all_ratings

  if params[:ratings]
    @ratings_to_show = params[:ratings].keys
    session[:ratings_to_show] = @ratings_to_show
  elsif session[:ratings_to_show]
    @ratings_to_show = session[:ratings_to_show]
  else
    @ratings_to_show = Movie.all_ratings
    session[:ratings_to_show] = @ratings_to_show
  end

  if params[:sort_by]
    @sort_by = params[:sort_by]
    session[:sort_by] = @sort_by
  elsif session[:sort_by]
    @sort_by = session[:sort_by]
  else
    @sort_by = nil
    session[:sort_by] = nil
  end

  @ratings_to_show = Movie.all_ratings if @ratings_to_show.empty?
  @movies = Movie.with_ratings(@ratings_to_show)
  @movies = @movies.order(@sort_by) if @sort_by.present?
end

  def show; end

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

  def edit; end

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
