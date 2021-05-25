class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[ show edit update destroy]

  def index
    @q = Recipe.ransack(params[:q])
    @recipes = Recipe.parse_search_params(params, @q.result).order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @favorite_exists = Favorite.where(recipe: @recipe, user: current_user) == [] ? false : true
    @review = Review.new
    @comment = @recipe.comments.build
    @comments = @recipe.comments.by_add
    respond_to do |format|
      format.html
      format.pdf do
        render template: "recipes/show.html.erb", pdf: "Recipe ID: #{@recipe.id} - " + Time.zone.now.strftime('%v %H:%M:%S').to_s,
                          viewport_size: '1280x1024', javascript_delay: 5000
      end
    end
  end

  def new
    @recipe = Recipe.new
    authorize @recipe

    @recipe.ingredients.build
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
    @recipe.user ||= current_user if current_user.admin? || current_user.moderator?
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
