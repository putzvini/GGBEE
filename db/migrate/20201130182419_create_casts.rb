class CreateCasts < ActiveRecord::Migration[6.0]
  def change
    create_table :casts do |t|
      t.string :cast_url
      t.date :cast_date
      t.time :cast_time
      t.integer :cast_view
      t.integer :cast_like
      t.integer :cast_dislike
      t.integer :cast_comment

      t.belongs_to :round, null: false, foreign_key: true


      t.timestamps
    end
  end
end
