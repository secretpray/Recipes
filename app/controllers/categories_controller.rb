class CategoriesController < ApplicationController

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_category, only: %i[ show edit update destroy]

  def index
    @categories = Category.order(:name)
  end

  def show; end

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

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: "Category was successfully created." }
      else
        flash[:danger] = 'Category not created'
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
        flash[:danger] = 'Category not updated'
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
    params.require(:category).permit(:name)
  end
end
