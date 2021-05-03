class CommentsController < ApplicationController
  before_action :set_recipe

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.recipe = @recipe

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.recipe, notice: "Comment was successfully created." }
      else
        format.html { redirect_to recipe_path(@recipe), alert: "Can`t create a Comment." }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :recipe_id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
