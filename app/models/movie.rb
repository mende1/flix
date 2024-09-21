class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17]

  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :critics, through: :reviews, source: :user

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, inclusion: { in: RATINGS }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }

  scope :released, -> { where('released_on < ?', Time.now).order(released_on: :desc) }
  scope :upcoming, -> { where('released_on > ?', Time.now).order(released_on: :asc) }
  scope :recent, ->(max=5) { released.limit(max) }
  scope :hits, -> { where('total_gross > 300000000').order(total_gross: :desc) }
  scope :flops, -> { where('total_gross < 225000000').order(total_gross: :asc) }
  scope :grossed_less_than, ->(amount) { released.where("total_gross < ?", amount) }
  scope :grossed_greater_than, ->(amount) { released.where("total_gross > ?", amount) }

  def self.with_average_stars
    left_joins(:reviews)
      .group("movies.id")
      .select("movies.*, AVG(reviews.stars) as average_stars")
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

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = title.parameterize
  end
end
