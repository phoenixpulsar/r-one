require "json"
require "securerandom"

module Integrations
  class StripeClient
    CheckoutSession = Struct.new(:id, :url, :status, keyword_init: true)

    def initialize(api_key: ENV.fetch("STRIPE_API_KEY", nil))
      @api_key = api_key
    end

    def create_checkout_session(cart: {})
      CheckoutSession.new(
        id: "cs_test_#{SecureRandom.hex(8)}",
        url: "https://dashboard.stripe.com/test/checkout/sessions/new",
        status: "draft"
      )
    end

    def webhook_event(payload:, signature: nil)
      JSON.parse(payload).merge("signature" => signature)
    end

    def handle_event(event)
      Rails.logger.info("Stripe event received", event: event)
      event
    end
  end
end
