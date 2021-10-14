class TagsController < ApplicationController

  def show
    @tag = Tag.find_by(name: params[:id])
    @recipes = @tag.recipes
  end

  # custom path for generate path with id params
  def autosearch
    @tag = Tag.find(params[:id])
    @recipes = @tag.recipes
    render 'show'
  end
end
