class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :favories, dependent: :destroy

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 4, allow_blank: true }
end
