class Player < ApplicationRecord
  belongs_to :team
  validates :player_name, :player_nick, presence: true
end
