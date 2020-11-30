class Team < ApplicationRecord
  belongs_to :match
  validates :team_name, :team_long_name, :team_tag, presence: true
end
