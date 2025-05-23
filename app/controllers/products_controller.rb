class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_admin_user!, except: [:index, :show]

  # GET /products or /products.json
  def index
    @products = Product.all

    # Filter by predefined filter
    case params[:filter]
    when 'on_sale'
      @products = @products.where(on_sale: true)
    when 'new'
      @products = @products.where('created_at >= ?', 3.days.ago)
    when 'recently_updated'
      @products = @products.where('updated_at >= ?', 3.days.ago)
                           .where.not('created_at = updated_at')
    end

    # Filter by category
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Filter by search keyword (name or description, case-insensitive)
    if params[:search].present?
      keyword = "%#{params[:search].downcase}%"
      @products = @products.where("LOWER(name) LIKE :keyword OR LOWER(description) LIKE :keyword", keyword: keyword)
    end

    # Pagination
    @products = @products.page(params[:page]).per(8)
  end




  # GET /products/1 or /products/1.json
  def show
    @product = Product.find_by(id: params[:id])
    redirect_to products_path, alert: "Product not found." unless @product
  end


  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock_quantity, :category_id, :image)
    end
end
