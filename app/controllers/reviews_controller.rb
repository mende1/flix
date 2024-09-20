class ReviewsController < ApplicationController
  before_action :require_signin
  before_action :set_movie
  before_action :set_review, only: %i[show edit update destroy]

  def index
    @reviews = @movie.most_recent_reviews
  end

  def show; end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      @new_review = Review.new(movie: @movie)
      flash.now[:notice] = "Thanks for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      flash.now[:notice] = "Review successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy

    flash.now[:notice] = "Review successfully deleted!"
  end

  private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
