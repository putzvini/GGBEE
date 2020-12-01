class ChangeCastViewFromCasts < ActiveRecord::Migration[6.0]
  def change
    remove_column :casts, :cast_time
    add_column :casts, :cast_time, :integer

    remove_column :matches, :match_time
    add_column :matches, :match_time, :integer
  end
end
