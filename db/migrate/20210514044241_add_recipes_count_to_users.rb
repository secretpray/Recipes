class AddRecipesCountToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :recipes_count, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :recipes_count
  end
end
