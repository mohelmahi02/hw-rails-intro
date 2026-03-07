class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    @all_ratings = Movie.all_ratings

    if params[:ratings]
      @selected_ratings = params[:ratings]
      session[:ratings] = @selected_ratings
    elsif session[:ratings]
      @selected_ratings = session[:ratings]
    else
      @selected_ratings = Movie.all_ratings.index_with("1")
      session[:ratings] = @selected_ratings
    end

    if params[:sort_by]
      @sort_by = params[:sort_by]
      session[:sort_by] = @sort_by
    elsif session[:sort_by]
      @sort_by = session[:sort_by]
    end

    @movies = Movie.where(rating: @selected_ratings.keys)
    @movies = @movies.order(@sort_by) if @sort_by.present?
  end

  def show; end
  def new; @movie = Movie.new; end

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
