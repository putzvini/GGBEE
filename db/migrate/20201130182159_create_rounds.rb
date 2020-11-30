class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.string :round_stage
      t.integer :round_day
      t.date :round_date

      t.timestamps
    end
  end
end
