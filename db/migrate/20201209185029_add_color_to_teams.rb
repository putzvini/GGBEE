class AddColorToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :team_color, :string
  end
end
