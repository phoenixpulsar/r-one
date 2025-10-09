class StripeWebhooksController < ApplicationController
  skip_before_action :require_authentication
  protect_from_forgery with: :null_session

  def create
    event = stripe_client.webhook_event(payload: request.raw_post, signature: request.headers["Stripe-Signature"])
    stripe_client.handle_event(event)
    head :ok
  rescue JSON::ParserError => error
    render json: { error: error.message }, status: :bad_request
  end

  private
    def stripe_client
      @stripe_client ||= Integrations::StripeClient.new
    end
end
