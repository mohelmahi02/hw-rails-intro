class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  # GET /movies
  def index
    @all_ratings = Movie.all_ratings

    # ---- Ratings filtering ----
    if params[:ratings].present? && params[:ratings].any?
      @ratings_to_show = params[:ratings].keys
      session[:ratings] = params[:ratings]
    elsif params[:ratings].present? && params[:ratings].empty?
      @ratings_to_show = @all_ratings
      session[:ratings] = Hash[@all_ratings.map { |r| [r, 1] }]
    elsif session[:ratings].present?
      redirect_to movies_path(ratings: session[:ratings], sort_by: session[:sort_by]) and return
    else
      @ratings_to_show = @all_ratings
    end

    # ---- Sorting ----
    if params[:sort_by].present?
      @sort_by = params[:sort_by]
      session[:sort_by] = @sort_by
    else
      @sort_by = session[:sort_by]
    end

    # ---- Fetch movies ----
    @movies = Movie.with_ratings(@ratings_to_show)
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