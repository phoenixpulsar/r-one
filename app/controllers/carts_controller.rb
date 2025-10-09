class CartsController < ApplicationController
  skip_before_action :require_authentication

  def show
    @items = sample_items
    @subtotal_cents = @items.sum { |item| item[:product].price_cents * item[:quantity] }
    @shipping_cents = 1200
    @tax_cents = (@subtotal_cents * 0.0825).round
    @total_cents = @subtotal_cents + @shipping_cents + @tax_cents
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
          product: Product.catalog.second,
          quantity: 2,
          size: "M",
          color: "Evergreen"
        }
      ]
    end
end
