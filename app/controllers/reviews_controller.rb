class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_recipe, only: [:new, :create]
  
  def index
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @reviews = @recipe.reviews
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = @recipe.reviews.build(review_params)
    @review.user_id = current_user.id
    authorize @review

    if @review.save
      redirect_to recipe_reviews_path(@review.recipe)
    else
      @comment = @recipe.comments.build
      @comments = @recipe.comments.by_add
      render "recipes/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:recipe_id, :score, :content)
  end

  def set_recipe
    @recipe = Recipe.friendly.find(params[:recipe_id])
  end
end
