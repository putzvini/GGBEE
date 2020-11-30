class Tournament < ApplicationRecord
  has_many :rounds
  validates :season, :split, presence: true
end
