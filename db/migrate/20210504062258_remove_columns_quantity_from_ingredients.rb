class RemoveColumnsQuantityFromIngredients < ActiveRecord::Migration[6.1]
  def change
    remove_column :ingredients, :quantity
  end
end
