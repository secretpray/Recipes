class RecipeStepsController < ApplicationController
  # include Wicked::Wizard::Translated
  include Wicked::Wizard

  before_action :set_progress, only: [:show, :update]

  steps :add_more_info, :add_ingredients, :add_steps

  def show
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients ||= @recipe.ingredients.build
    @steps ||= @recipe.steps.build

    render_wizard
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])

    render_wizard @recipe
  end

  private

  def redirect_to_finish_wizzard
    redirect_to recipes_path, notice: 'Thanks you for create new Recipe.'
  end

  def set_progress
    if wizard_steps.any? && wizard_steps.index(step).present?
      @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
    else
      @progress = 0
    end
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description,
                                    :serves, :time_prep,
                                    :time_cook, :time_ps,
                                    :nutrion_ps_kcal, :nutrion_ps_fat,
                                    :nutrion_ps_saturates, :nutrion_ps_carbs,
                                    :nutrion_ps_sugar, :nutrion_ps_fibre,
                                    :nutrion_ps_protein, :nutrion_ps_salt,
                                    :prep_easy, :gluten_free,
                                    :peanut_free, :sugar_free,
                                    :salt_free, :kosher,
                                    :vegan, :vegetarin,
                                    :user_id, :category_id,
                                    :all_tags, :recipe_image,
                                    { step_images: [] },
            ingredients_attributes: [:id, :content, :_destroy],
                  steps_attributes: [:id, :method, :_destroy])
  end
end
