module Integrations
  class StripeCheckoutsController < ApplicationController
    skip_before_action :require_authentication
    protect_from_forgery with: :null_session

    def create
      checkout_session = stripe_client.create_checkout_session(cart: checkout_payload)
      render json: {
        id: checkout_session.id,
        url: checkout_session.url,
        status: checkout_session.status
      }
    end

    private
      def checkout_payload
        return { items: [] } unless params[:cart].present?

        params.require(:cart).permit(:shipping_rate, items: %i[id quantity price_cents name]).to_h
      end

      def stripe_client
        @stripe_client ||= Integrations::StripeClient.new
      end
  end
end
