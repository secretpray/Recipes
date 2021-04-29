module RecipesHelper

  def link_form(recipe)
    recipe.persisted? ? 'Update' : 'Create'
  end
end
