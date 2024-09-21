class GenresController < ApplicationController
  before_action :set_genre, only: %i[show edit update destroy]

  def index
    @genres = Genre.order(:name)
  end

  def show
    @movies = @genre.movies
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      flash[:notice] = "New genre successfully created!"
      redirect_to @genre
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @genre.update(genre_params)
      flash[:notice] = "Genre successfully updated!"
      redirect_to @genre
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @genre.destroy

    redirect_to genres_url, status: :see_other, alert: "Genre successfully deleted!"
  end

  private

  def set_genre
    @genre = Genre.find_by!(slug: params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, movie_ids: [])
  end
end
