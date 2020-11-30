class CreateCasts < ActiveRecord::Migration[6.0]
  def change
    create_table :casts do |t|
      t.date :cast_date
      t.time :cast_time
      t.integer :cast_view
      t.integer :cast_like
      t.ineteger :cast_dislike
      t.integer :cast_comment

      t.timestamps
    end
  end
end
