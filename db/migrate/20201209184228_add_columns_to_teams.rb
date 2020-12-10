class AddColumnsToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :team_twitter, :string
    add_column :teams, :team_twitch, :string
    add_column :teams, :team_youtube, :string
    add_column :teams, :team_ig, :string
    add_column :teams, :team_fb, :string
    add_column :teams, :team_cup, :integer
  end
end
