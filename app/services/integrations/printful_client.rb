require "json"

module Integrations
  class PrintfulClient
    def initialize(api_key: ENV.fetch("PRINTFUL_API_KEY", nil))
      @api_key = api_key
    end

    def catalog_preview
      Product.catalog.map do |product|
        {
          id: product.id,
          name: product.name,
          retail_price: product.formatted_price,
          printful_sku: product.printful_sku,
          thumbnail_url: product.primary_image,
          synced: product.synced?
        }
      end
    end

    def queue_product_sync(product)
      {
        product_id: product.id,
        printful_sku: product.printful_sku,
        queued_at: Time.current.iso8601,
        status: "queued"
      }
    end

    def handle_webhook(payload)
      data = JSON.parse(payload)
      Rails.logger.info("Printful webhook", payload: data)
      data
    end
  end
end
