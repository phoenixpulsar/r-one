class ProductsController < ApplicationController
  skip_before_action :require_authentication
  before_action :set_categories

  def index
    @selected_category = params[:category]
    @products = if @selected_category.present?
      Product.catalog.select { |product| product.category == @selected_category }
    else
      Product.catalog
    end
  end

  def show
    @product = Product.find(params.expect(:id))
    @related_products = Product.catalog.reject { |product| product.id == @product.id }.first(4)
  end

  private
    def set_categories
      @categories = Product.catalog.map(&:category).uniq.compact
    end
end
