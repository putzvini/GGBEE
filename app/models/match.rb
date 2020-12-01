class Match < ApplicationRecord
  belongs_to :cast
  belongs_to :blue_team, class_name: 'Team', foreign_key: 'blue_team_id' 
  belongs_to :red_team, class_name: 'Team', foreign_key: 'red_team_id'

  validates :match_url, :match_date, :match_time, :match_view, :match_like, :match_dislike, :match_comment, presence: true
end
