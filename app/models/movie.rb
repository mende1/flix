class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17]

  has_many :reviews, dependent: :destroy
  has_many :critics, through: :reviews, source: :user

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, inclusion: { in: RATINGS }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }

  def self.released
    where('released_on < ?', Time.now).order(released_on: :desc)
  end

  def self.with_average_stars
    left_joins(:reviews)
      .group("movies.id")
      .select("movies.*, AVG(reviews.stars) as average_stars")
  end

  def self.hits
    where(total_gross: 300_000_000..).order(total_gross: :desc)
  end

  def self.flops
    where(total_gross: ..225_000_000).order(total_gross: :asc)
  end

  def self.recently_added
    order(created_at: :desc).limit(3)
  end

  def most_recent_reviews
    reviews.order(created_at: :desc)
  end

  def average_stars_by_movie
    @average_stars_by_movie ||= reviews.average(:stars) || 0
  end

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end
end
