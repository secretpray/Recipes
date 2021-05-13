class SearchController < ApplicationController
  
  def query
    @search_param = params[:search].to_s.downcase
    @search_string = '%' + @search_param.gsub(" ","%") + '%'
    @recipes = Recipe.where('LOWER(title) like ?', @search_string)
    render layout:false
  end
end