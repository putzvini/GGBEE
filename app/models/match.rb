class Match < ApplicationRecord
  belongs_to :cast
  has_many :teams

  validates :match_url, :match_date, :match_time, :match_view, :match_like, :match_dislike, :match_comment, presence: true
end
