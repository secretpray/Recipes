class FavoritesController < ApplicationController
  before_action :set_recipe

  def update
    # unless current_user.favorites.find_by(recipe_id: @recipe.id).present?
    # unless Favorite.where(recipe: @recipe, user: current_user).any?
    favorite = Favorite.where(recipe: @recipe, user: current_user)
    
    if favorite == []
      Favorite.create(recipe: @recipe, user: current_user) 
      @favorite_exists = true
    else
      favorite.destroy_all
      @favorite_exists = false
    end

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe])
  end
end
