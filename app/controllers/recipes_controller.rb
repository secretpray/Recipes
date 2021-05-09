class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[ show edit update destroy]

  def index
    @recipes = Recipe.recent.page(params[:page]).per(12)
  end

  def show
    @favorite_exists = Favorite.where(recipe: @recipe, user: current_user) == [] ? false : true
    @review = Review.new
    @comment = @recipe.comments.build
    @comments = @recipe.comments.by_add
  end

  def new
    @recipe = Recipe.new
    authorize @recipe

    @recipe.ingredients.build   # (has_many or has_many :through)
    @recipe.steps.build         
  end

  def edit
    authorize @recipe

    @recipe.steps.any? ? @recipe.steps : @recipe.steps.build
    @recipe.ingredients.any? ? @recipe.ingredients : @recipe.ingredients.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    authorize @recipe

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @recipe

    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @recipe

    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
    end
  end
  
  def favorites
    @favorites = current_user.favorites.page(params[:page]).per(12)
  end
  
  private

  def set_recipe
    @recipe = Recipe.with_attached_step_images.friendly.find(params[:id])
  end
  
  def recipe_params
    params.require(:recipe).permit(:title, :description, :user_id, :category_id, :all_tags, :recipe_image, { step_images: [] },
    ingredients_attributes: [:id, :content, :_destroy],
    steps_attributes: [:id, :method, :_destroy])
  end
end
