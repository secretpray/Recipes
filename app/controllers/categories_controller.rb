class CategoriesController < ApplicationController

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_category, only: %i[ show edit update destroy]

  def index
    @categories = Category.order(:name)
  end

  def show
    @recipes = Recipe.where(category_id: [@category.subtree_ids])
  end

  def new
    @category = Category.new
    # authorize @category
  end

  def edit
    # authorize @category
  end

  def create
    @category = Category.new(category_params)
    # authorize @category
    check_uniq_parent_and_child

    respond_to do |format|
      if !@category.errors.any? && @category.save
        format.html { redirect_to categories_path, notice: "Category was successfully created." }
      else
        # flash[:alert] = 'New Category not created'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    # authorize @category

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: "Category was successfully updated." }
      else
        flash[:alert] = 'Category not updated'
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # authorize @category

    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_path, notice: "Category was successfully destroyed." }
    end
  end


  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def check_uniq_parent_and_child
    return if params[:category][:parent_id].empty?

    child_name = params[:category][:name]
    parent_name = Category.find_by_id(params[:category][:parent_id]).name
    if child_name == parent_name
      @category.errors.add(:category, 'name and category parent are the same!')
    end
  end
end
