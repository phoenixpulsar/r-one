module Printful
  class ProductsController < ApplicationController
    skip_before_action :require_authentication
    protect_from_forgery with: :null_session

    def index
      render json: { data: printful_client.catalog_preview }
    end

    def create
      product = Product.find(params.expect(:product_id))
      response = printful_client.queue_product_sync(product)
      render json: response, status: :accepted
    end

    private
      def printful_client
        @printful_client ||= Integrations::PrintfulClient.new
      end
  end
end
