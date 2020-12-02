class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.string :round_stage
      t.string :round_day
      t.date :round_date

      t.belongs_to :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
