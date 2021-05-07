module RecipesHelper

  def image_preview(recipe)
    if recipe.recipe_image.attached? 
      image_tag recipe.recipe_image.variant(resize: '200x200!').processed
    else
      image_tag("Default_image.png", size: '200x200')
    end
  end
end
