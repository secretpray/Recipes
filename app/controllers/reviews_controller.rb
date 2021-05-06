class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @reviews = @recipe.reviews
  end

  def create
    # binding.pry
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @review = @recipe.reviews.build(review_params)
    @review.user_id = current_user.id

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
end
