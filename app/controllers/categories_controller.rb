class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories or /categories.json
  def index
    @user = current_user
    @categories = @user.category
  end

  # GET /categories/1 or /categories/1.json
  def show
    @category = Category.find(params[:id])
    @expenses = @category.expense.order(created_at: :desc)
    @categories = current_user.category
  end

  # GET /categories/new
  def new
    @user = current_user
    @category = Category.new
  end

  # POST /categories or /categories.json
  def create
    @user = current_user
    @category = @user.category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'Category created successfully.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: 'Category updated successfully .' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category deleted successfully.' }
      format.json { head :no_content }
    end
  end

  private

  # Callbacks to share common setup between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Allow a list of trusted parameters.
  def category_params
    params.require(:category).permit(:name, :icon)
  end
end