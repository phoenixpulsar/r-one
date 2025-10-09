module Printful
  class WebhooksController < ApplicationController
    skip_before_action :require_authentication
    protect_from_forgery with: :null_session

    def create
      printful_client.handle_webhook(request.raw_post)
      head :ok
    rescue JSON::ParserError => error
      render json: { error: error.message }, status: :bad_request
    end

    private
      def printful_client
        @printful_client ||= Integrations::PrintfulClient.new
      end
  end
end
