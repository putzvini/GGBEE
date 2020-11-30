class Round < ApplicationRecord
  belongs_to :tournament
  has_one :cast

  validates :round_stage, :round_day, :round_date, presence: true
end
