class MoviesController < ApplicationController
  before_action :set_movie_id, only: %w[show edit update destroy]

  def index
    @movies = Movie.released.with_average_stars
  end

  def show
    @reviews = @movie.most_recent_reviews
    @review = Review.new(movie: @movie)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy

    redirect_to movies_url, status: :see_other, alert: "Movie successfully deleted!"
  end

  private

  def movie_params
    params.require(:movie)
          .permit(:title, :rating, :total_gross, :description, :released_on,
                  :director, :duration, :image_file_name)
  end

  def set_movie_id
    @movie = Movie.find(params[:id])
  end
end
