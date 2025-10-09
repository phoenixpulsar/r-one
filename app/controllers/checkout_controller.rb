class CheckoutController < ApplicationController
  skip_before_action :require_authentication

  def show
    @items = sample_items
    @subtotal_cents = @items.sum { |item| item[:product].price_cents * item[:quantity] }
    @shipping_methods = [
      { id: "standard", label: "Standard (5-7 days)", eta: "Arrives Jan 22 - Jan 24", price_cents: 1200 },
      { id: "express", label: "Express (2-3 days)", eta: "Arrives Jan 18 - Jan 19", price_cents: 2200 }
    ]
    @selected_shipping = @shipping_methods.first
    @tax_cents = (@subtotal_cents * 0.0825).round
    @total_cents = @subtotal_cents + @selected_shipping[:price_cents] + @tax_cents
  end

  private
    def sample_items
      [
        {
          product: Product.catalog.first,
          quantity: 1,
          size: "L",
          color: "Charcoal"
        },
        {
          product: Product.catalog.third,
          quantity: 1,
          size: "OS",
          color: "Onyx"
        }
      ]
    end
end
