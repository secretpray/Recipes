class UsersController < ApplicationController
  before_action :set_user

  def show
    @recent_recipes = @user.recipes.recent.limit(4)
  end

  def recipes
    @all_recipes = @user.recipes.page(params[:page]).per(9)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
