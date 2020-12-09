class AddPlayerTwitterToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :player_twitter, :string
  end
end
