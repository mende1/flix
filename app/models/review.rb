class Review < ApplicationRecord
  STARS = [1, 2, 3, 4, 5]

  belongs_to :movie
  belongs_to :user

  validates :stars, inclusion: { in: STARS, message: "must be between 1 and 5" }
  validates :comment, length: { minimum: 5 }

  scope :past_n_days, ->(days) { where("created_at >= ?" , days.days.ago) }

  def self.most_recent
    order(created_at: :desc)
  end

  def stars_as_percentage
    (stars / 5.0) * 100.0
  end
end
