class AutosearchController < ApplicationController

  def autosearch

    if params[:term].present? && params[:term].size > 1
      @recipes = Recipe.order(created_at: :desc).global_post_search(params[:term]).limit(5)
      @users = User.order(created_at: :desc).global_user_search(params[:term]).limit(5)
      @tags = Tag.order(created_at: :desc).global_tag_search(params[:term]).limit(5)
    end

    respond_to do |format|
      format.json { render json:{
          recipes: RecipeSerializer.new(@recipes, params: { context: self }).to_json,
          users: UserSerializer.new(@users, params: { context: self }).to_json,
          tags: TagSerializer.new(@tags, params: { context: self }).to_json }
          }
      end
    end
end
