class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :team_long_name
      t.string :team_tag

      t.belongs_to :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
