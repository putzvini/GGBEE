class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :team_long_name
      t.string :team_tag

      t.timestamps
    end
  end
end
