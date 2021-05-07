class AddCategoryIdToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :category_id, :integer
    add_index :recipes, :category_id
  end
end
