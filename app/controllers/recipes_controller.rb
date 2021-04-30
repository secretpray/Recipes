class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  def index
    @recipes = Recipe.recent
  end

  def show; end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build   # (has_many or has_many :through)
    @recipe.steps.build         # (has_many or has_many :through)
  end

  def edit; end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_recipe
      @recipe = Recipe.with_attached_step_images.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :description, :user_id, :recipe_image, { step_images: [] },
                                    ingredients_attributes: [:id, :content, :quantity, :_destroy],
                                    steps_attributes: [:id, :method, :_destroy])
    end
end
