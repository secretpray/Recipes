class CommentsController < ApplicationController
  before_action :set_recipe, only: %i[edit update create]
  before_action :find_comment, only: %i[edit update destroy]
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    authorize @comment

    @comment.recipe = @recipe
    @comment.save
  end

  def edit
    # authorize @comment
  end

  def update
    # authorize @comment
    @comment.user = current_user
    # authorize @comment

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.recipe, notice: "Comment was successfully updated." }
        format.js { redirect_to @comment.recipe, notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def upvote
    @comment = Comment.find(params[:recipe_id])
    if current_user.voted_up_on? @comment
      @comment.unvote_by current_user
    else
      @comment.upvote_by current_user
    end
    render "vote.js.erb"
  end

  def downvote
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
