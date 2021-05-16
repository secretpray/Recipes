class CommentsController < ApplicationController
  before_action :set_recipe, only: :create
  before_action :find_comment, only: %i[destroy]
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    authorize @comment

    @comment.recipe = @recipe
    @comment.save
  end

  def upvote
    # binding.pry
    @comment = Comment.find(params[:recipe_id])
    if current_user.voted_up_on? @comment
      @comment.unvote_by current_user
    else
      @comment.upvote_by current_user
    end
    render "vote.js.erb"
  end

  def downvote
    # binding.pry
    @comment = Comment.find(params[:recipe_id])
    if current_user.voted_down_on? @comment
      @comment.unvote_by current_user
    else
      @comment.downvote_by current_user
    end
    render "vote.js.erb"
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
