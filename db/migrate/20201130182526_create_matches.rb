class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :cast_url
      t.date :match_date
      t.time :match_time
      t.integer :match_view
      t.integer :match_like
      t.integer :match_dislike
      t.integer :match_comment

      t.belongs_to :cast, null: false, foreign_key: true

      t.timestamps
    end
  end
end
