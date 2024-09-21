class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 4, allow_blank: true }

  scope :by_name, -> { order(:name) }
  scope :non_admin, -> { by_name.where(admin: false) }
end
