class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :player_name
      t.string :player_nick
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
