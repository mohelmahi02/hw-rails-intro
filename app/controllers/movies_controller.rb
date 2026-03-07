class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  def index
  @all_ratings = Movie.all_ratings
  @selected_ratings = params[:ratings] || session[:ratings] || {}
  
  if params[:ratings] != session[:ratings] && @selected_ratings != {}
    session[:ratings] = @selected_ratings
    session[:sort] = params[:sort_by] || session[:sort_by]
    redirect_to movies_path(ratings: @selected_ratings, sort_by: session[:sort_by]) and return
  end
  
  sort = params[:sort_by] || session[:sort_by]
  session[:sort_by] = sort
  
  @sort_by = sort
  @movies = Movie.where(rating: @selected_ratings.keys).order(sort.to_s.empty? ? nil : sort)
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
