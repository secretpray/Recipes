class AddMoreAttrsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :serves, :integer
    add_column :recipes, :time_prep, :time
    add_column :recipes, :time_cook, :time
    add_column :recipes, :time_ps, :text
    add_column :recipes, :nutrion_ps_kcal, :integer
    add_column :recipes, :nutrion_ps_fat, :integer
    add_column :recipes, :nutrion_ps_saturates, :integer
    add_column :recipes, :nutrion_ps_carbs, :integer
    add_column :recipes, :nutrion_ps_sugar, :integer
    add_column :recipes, :nutrion_ps_fibre, :integer
    add_column :recipes, :nutrion_ps_protein, :integer
    add_column :recipes, :nutrion_ps_salt, :integer
    add_column :recipes, :prep_easy, :boolean
    add_column :recipes, :gluten_free, :boolean
    add_column :recipes, :peanut_free, :boolean
    add_column :recipes, :sugar_free, :boolean
    add_column :recipes, :salt_free, :boolean
    add_column :recipes, :kosher, :boolean
    add_column :recipes, :vegan, :boolean
    add_column :recipes, :vegetarin, :boolean
  end
end
