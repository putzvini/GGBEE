class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :match_url
      t.date :match_date
      t.time :match_time
      t.integer :match_view
      t.integer :match_like
      t.integer :match_dislike
      t.integer :match_comment

      t.references :cast, foreign_key: true
      t.references :blue_team,  foreign_key: {to_table: 'teams'}
      t.references :red_team, foreign_key: {to_table: 'teams'}

      t.timestamps
    end
  end
end
