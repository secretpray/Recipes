class DashboardsController < ApplicationController

  def index
    @recent = Recipe.recent.limit(6)
    @best = Recipe.best.limit(6)
  end

  def search
    if params[:search].present? && params[:search].size > 1
      @recipes = Recipe.order(created_at: :desc).global_search(params[:search]).limit(5)
    end
    render layout: false
  end
end
