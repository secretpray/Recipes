class UsersController < ApplicationController
  before_action :set_user

  def show
    @recent_recipes = @user.recipes.recent.limit(4)
  end

  def recipes
    @all_recipes = @user.recipes.page(params[:page]).per(9)
  end

  def change_status
    if params[:status].present? && User::STATUSES.include?(params[:status].to_sym)
      @user.update(status: params[:status])
    end
    redirect_to @user, notice: "Status updated to #{@user.status}"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
