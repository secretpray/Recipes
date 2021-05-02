class DashboardController < ApplicationController

  def index
    @recent = Recipe.recent.limit(6)
    @best = Recipe.best.limit(6)
  end
end
