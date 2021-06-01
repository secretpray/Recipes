class DashboardController < ApplicationController

  def index
    @recent = Recipe.recent.limit(6)
    @best = Recipe.best.limit(6)
  end

  def search
    # @recipes = Recipe.where('title ILIKE ? OR description ILIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    @recipes = Recipe.order(created_at: :desc).global_search(params[:search]).limit(5)
    render layout: false
  end
end
