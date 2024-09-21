class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    @movie.fans << current_user
    @favorite = current_user.favorites.find_by(movie_id: @movie.id)
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    @favorite = nil
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
