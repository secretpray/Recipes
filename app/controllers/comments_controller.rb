class CommentsController < ApplicationController
  before_action :set_recipe, only: :create
  before_action :find_comment, only: :destroy
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    authorize @comment
    @comment.recipe = @recipe
    # @comment.save

    respond_to do |format|
      if @comment.save
        # format.html { redirect_to @comment.recipe, notice: "Comment was successfully created!" }
        format.js
      else
        # format.html { redirect_to question_path(@question), alert: "Can`t create a Comment." }
        format.js
      end
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :recipe_id)
  end

  def set_recipe
    @recipe = Recipe.friendly.find(params[:recipe_id])
  end

  def find_comment
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id])
  end
end
