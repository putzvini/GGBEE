class Team < ApplicationRecord
  validates :team_name, :team_long_name, :team_tag, presence: true
end
