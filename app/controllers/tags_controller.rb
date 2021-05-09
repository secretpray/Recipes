class TagsController < ApplicationController
  
  def show
    @tag = Tag.find_by(name: params[:id])
    @recipes = @tag.recipes
  end

end