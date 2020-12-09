class AddTitleToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :title, :integer
  end
end
