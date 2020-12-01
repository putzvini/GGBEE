class Cast < ApplicationRecord
  belongs_to :round
  has_many :matches

  validates :cast_url, :cast_date, :cast_time, :cast_view, :cast_like, :cast_dislike, :cast_comment, presence: true
end
