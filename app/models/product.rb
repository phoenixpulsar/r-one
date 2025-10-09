class Product
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :integer
  attribute :name, :string
  attribute :description, :string
  attribute :price_cents, :integer, default: 0
  attribute :category, :string
  attribute :badge, :string
  attribute :printful_sku, :string
  attribute :status, :string, default: "draft"
  attribute :materials, default: []
  attribute :images, default: []
  attribute :colors, default: []
  attribute :sizes, default: []
  attribute :care, default: []

  class << self
    def catalog
      @catalog ||= build_catalog
    end

    def featured
      catalog.select { |product| product.badge == "featured" }.presence || catalog.first(4)
    end

    def new_arrivals
      catalog.last(4)
    end

    def best_sellers
      catalog.first(4)
    end

    def find(id)
      catalog.detect { |product| product.id.to_s == id.to_s } || raise(ActiveRecord::RecordNotFound, "Couldn't find Product with 'id'=#{id}")
    end

    private
      def build_catalog
        [
          new(
            id: 1,
            name: "Signal Heavyweight Hoodie",
            description: "Premium 400 GSM cotton hoodie with an oversized fit and tonal embroidered logo.",
            price_cents: 9800,
            category: "Streetwear",
            badge: "featured",
            printful_sku: "HOODIE-001",
            status: "synced",
            images: [
              "https://images.unsplash.com/photo-1542293787938-4d2226c12e72?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1617137968427-85924c800b3f?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=900&q=80"
            ],
            colors: ["Charcoal", "Bone", "Deep Navy"],
            sizes: %w[XS S M L XL XXL],
            materials: ["100% organic cotton", "Ribbed cuffs", "Brushed interior"],
            care: ["Machine wash cold", "Hang dry", "Do not bleach"]
          ),
          new(
            id: 2,
            name: "North Loop Puffer Jacket",
            description: "Packable warmth with recycled insulation and weather-resistant shell.",
            price_cents: 14800,
            category: "Outerwear",
            badge: "featured",
            printful_sku: "PUFFER-002",
            status: "synced",
            images: [
              "https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1516826957135-700dedea698c?auto=format&fit=crop&w=900&q=80"
            ],
            colors: ["Evergreen", "Onyx"],
            sizes: %w[S M L XL],
            materials: ["Recycled polyester shell", "PrimaLoft® insulation"],
            care: ["Spot clean", "Line dry"]
          ),
          new(
            id: 3,
            name: "Analog Studio Dad Hat",
            description: "Soft unstructured twill with metal clasp and tonal puff print.",
            price_cents: 3600,
            category: "Accessories",
            badge: "featured",
            printful_sku: "HAT-003",
            status: "synced",
            images: [
              "https://images.unsplash.com/photo-1516641398374-6a7cf0f3c87e?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=900&q=80"
            ],
            colors: ["Sand", "Onyx", "Storm"],
            sizes: ["OS"],
            materials: ["100% cotton twill"],
            care: ["Hand wash", "Air dry"]
          ),
          new(
            id: 4,
            name: "Atlas Everyday Tee",
            description: "Garment-dyed midweight tee with a structured drape.",
            price_cents: 4200,
            category: "Streetwear",
            badge: "featured",
            printful_sku: "TEE-004",
            status: "draft",
            images: [
              "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=900&q=80"
            ],
            colors: ["Bone", "Slate", "Rust"],
            sizes: %w[XS S M L XL XXL],
            materials: ["240 GSM cotton", "Pre-shrunk"],
            care: ["Wash inside out", "Tumble dry low"]
          ),
          new(
            id: 5,
            name: "Framework Tech Long Sleeve",
            description: "Breathable mesh panels and flatlock seams for studio-to-street comfort.",
            price_cents: 6200,
            category: "Lifestyle",
            badge: "new",
            printful_sku: "LS-005",
            status: "draft",
            images: [
              "https://images.unsplash.com/photo-1523381210434-271e8be1f52b?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1469334031218-e382a71b716b?auto=format&fit=crop&w=900&q=80"
            ],
            colors: ["Concrete", "Midnight"],
            sizes: %w[XS S M L XL XXL],
            materials: ["Moisture-wicking poly blend", "Flatlock stitching"],
            care: ["Machine wash cold", "Lay flat to dry"]
          ),
          new(
            id: 6,
            name: "Transit Crossbody",
            description: "Compact sling with modular dividers and waterproof zippers.",
            price_cents: 8800,
            category: "Accessories",
            badge: "bestseller",
            printful_sku: "BAG-006",
            status: "synced",
            images: [
              "https://images.unsplash.com/photo-1523301343968-6a6ebf63c672?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1457269449834-928af64c684d?auto=format&fit=crop&w=900&q=80"
            ],
            colors: ["Onyx", "Stone"],
            sizes: ["OS"],
            materials: ["Cordura® nylon", "YKK Aquaguard zippers"],
            care: ["Spot clean"]
          ),
          new(
            id: 7,
            name: "Elements Track Pant",
            description: "Relaxed technical pant with articulated knees and hidden snaps.",
            price_cents: 10200,
            category: "Lifestyle",
            badge: "bestseller",
            printful_sku: "PANT-007",
            status: "draft",
            images: [
              "https://images.unsplash.com/photo-1514996937319-344454492b37?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=900&q=80"
            ],
            colors: ["Graphite", "Forest"],
            sizes: %w[XS S M L XL XXL],
            materials: ["4-way stretch nylon", "DWR coating"],
            care: ["Cold wash", "Hang dry"]
          ),
          new(
            id: 8,
            name: "Signal Beanie",
            description: "Ribbed knit beanie with minimal woven label and soft hand feel.",
            price_cents: 3200,
            category: "Accessories",
            badge: "new",
            printful_sku: "BEANIE-008",
            status: "synced",
            images: [
              "https://images.unsplash.com/photo-1516641398374-6a7cf0f3c87e?auto=format&fit=crop&w=900&q=80",
              "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=900&q=80"
            ],
            colors: ["Coal", "Moss"],
            sizes: ["OS"],
            materials: ["Acrylic blend"],
            care: ["Hand wash", "Lay flat to dry"]
          )
        ]
      end
  end

  def formatted_price
    ActiveSupport::NumberHelper.number_to_currency(price_cents / 100.0)
  end

  def price
    price_cents / 100.0
  end

  def primary_image
    images.first
  end

  def secondary_images
    images.drop(1)
  end

  def synced?
    status == "synced"
  end
end
