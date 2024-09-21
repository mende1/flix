class MoviesController < ApplicationController
  before_action :require_signin, :require_admin, except: %i[index show]
  before_action :set_movie_id, only: %w[show edit update destroy]

  def index
    @movies = Movie.send(movies_filter).with_average_stars
  end

  def show
    @reviews = @movie.most_recent_reviews
    @review = Review.new(movie: @movie)
    @genres = @movie.genres.order(:name)

    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
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

  def movies_filter
    if params[:filter].in? %i(upcoming recent hits flop)
      params[:filter]
    else
      :released
    end
  end

  def movie_params
    params.require(:movie)
          .permit(:title, :rating, :total_gross, :description, :released_on,
                  :director, :duration, :image_file_name, genre_ids: [])
  end

  def set_movie_id
    @movie = Movie.find_by!(slug: params[:id])
  end
end
