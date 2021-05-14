class AddFavoritesCountToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :favorites_count, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :favorites_count
  end
end
