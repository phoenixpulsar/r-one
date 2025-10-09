class StorefrontController < ApplicationController
  skip_before_action :require_authentication

  def index
    @featured_products = Product.featured
    @new_arrivals = Product.new_arrivals
    @best_sellers = Product.best_sellers
    @collections = [
      {
        name: "Streetwear Staples",
        description: "Layered essentials in premium fabrics for everyday flex.",
        image_url: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=900&q=80",
        href: products_path(category: "Streetwear")
      },
      {
        name: "Studio Creators",
        description: "Gear designed for designers, producers, and late-night makers.",
        image_url: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=900&q=80",
        href: products_path(category: "Lifestyle")
      },
      {
        name: "Weekend Escapes",
        description: "Technical layers and accessories built for spontaneity.",
        image_url: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80",
        href: products_path(category: "Outerwear")
      }
    ]

    @testimonials = [
      {
        name: "Jordan Blake",
        title: "Creative Director, Analog Studio",
        quote: "The quality is unreal. Printful fulfills every drop flawlessly and our community loves the fit.",
        avatar_url: "https://images.unsplash.com/photo-1487412912498-0447578fcca8?auto=format&fit=crop&w=200&q=80"
      },
      {
        name: "Ayana Wells",
        title: "Founder, Midnight Markets",
        quote: "Stripe checkout made launch day effortless. The store feels polished from first click to delivery.",
        avatar_url: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80"
      }
    ]

    @perks = [
      {
        title: "Print-on-demand fulfillment",
        description: "Every product routes to Printful automatically for production and tracked delivery.",
        icon: "truck"
      },
      {
        title: "Flexible payment flows",
        description: "Stripe Checkout sessions, saved cards, and subscription-ready billing out of the box.",
        icon: "credit-card"
      },
      {
        title: "Unified inventory",
        description: "Sync product metadata from Printful with our catalog to keep variants fresh.",
        icon: "layers"
      }
    ]
  end
end
