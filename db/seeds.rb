User.destroy_all
Post.destroy_all
Comment.destroy_all

puts "Creating users..."
user1 = User.create!(
  email: "alice@example.com",
  password: "password123",
  password_confirmation: "password123"
)

user2 = User.create!(
  email: "bob@example.com",
  password: "password123",
  password_confirmation: "password123"
)

user3 = User.create!(
  email: "charlie@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "Created #{User.count} users"

puts "Creating posts..."
post1 = user1.posts.create!(
  title: "Welcome to R-One Blog",
  body: "This is our first blog post. We're excited to share our thoughts with you!"
)

post2 = user1.posts.create!(
  title: "Getting Started with Rails 8",
  body: "Rails 8 brings many exciting new features including improved performance and better developer experience."
)

post3 = user2.posts.create!(
  title: "The Power of Hotwire",
  body: "Hotwire makes building reactive applications easier than ever. No need for heavy JavaScript frameworks!"
)

post4 = user2.posts.create!(
  title: "Deploying with Kamal",
  body: "Kamal simplifies the deployment process. Deploy anywhere with Docker in minutes."
)

post5 = user3.posts.create!(
  title: "Real-time Features with Action Cable",
  body: "Action Cable brings WebSocket support to Rails, enabling real-time features like live comments."
)

puts "Created #{Post.count} posts"

puts "Creating comments..."
post1.comments.create!(user: user2, content: "Great introduction! Looking forward to more posts.")
post1.comments.create!(user: user3, content: "Welcome! This looks like a great platform.")
post1.comments.create!(user: user1, content: "Thanks everyone for the warm welcome!")

post2.comments.create!(user: user2, content: "Rails 8 is amazing! The performance improvements are noticeable.")
post2.comments.create!(user: user3, content: "Can't wait to upgrade our apps to Rails 8.")

post3.comments.create!(user: user1, content: "Hotwire has been a game-changer for our team.")
post3.comments.create!(user: user3, content: "Agreed! The learning curve is much smaller than React.")

post4.comments.create!(user: user1, content: "We just deployed our first app with Kamal. So smooth!")
post4.comments.create!(user: user3, content: "Does it work well with SQLite in production?")
post4.comments.create!(user: user2, content: "Yes! We're using SQLite with Solid Queue and it's rock solid.")

post5.comments.create!(user: user1, content: "The real-time comments on this blog use Action Cable!")
post5.comments.create!(user: user2, content: "That's so cool to see it in action.")

puts "Created #{Comment.count} comments"

puts "\n✅ Seed data created successfully!"
puts "\nSample login credentials:"
puts "  Email: alice@example.com"
puts "  Password: password123"
puts "\nOther users: bob@example.com, charlie@example.com (same password)"

AvailabilitySlot.destroy_all
Pool.destroy_all

puts "\nCreating pools..."

pools_data = [
  {
    name: "Downtown Aquatic Center",
    address: "123 Main St",
    city: "San Francisco",
    state: "CA",
    zip_code: "94102",
    latitude: 37.7749,
    longitude: -122.4194,
    length_value: 25,
    length_unit: "yards",
    total_lanes: 6,
    verified: true,
    indoor: true,
    outdoor: false,
    has_photos: true,
    open_stall_showers: true,
    private_showers: true,
    day_lockers: true,
    byol_lockers: false,
    membership_type: "public",
    day_pass_available: true,
    price_per_hour: 15.00,
    lifeguard_on_duty: true,
    pull_buoy_available: true,
    kickboard_available: true,
    fins_available: false,
    has_coaches: true,
    accessible: true,
    masters_swimming: true,
    parking_available: true,
    paid_parking: false,
    description: "Modern aquatic facility in the heart of downtown with Olympic-size lanes."
  },
  {
    name: "Sunset Pool & Spa",
    address: "456 Beach Ave",
    city: "San Francisco",
    state: "CA",
    zip_code: "94116",
    latitude: 37.7577,
    longitude: -122.4870,
    length_value: 50,
    length_unit: "meters",
    total_lanes: 8,
    verified: true,
    indoor: false,
    outdoor: true,
    has_photos: true,
    open_stall_showers: false,
    private_showers: true,
    day_lockers: true,
    byol_lockers: true,
    membership_type: "private",
    day_pass_available: true,
    price_per_hour: 25.00,
    lifeguard_on_duty: true,
    pull_buoy_available: true,
    kickboard_available: true,
    fins_available: true,
    has_coaches: true,
    accessible: false,
    masters_swimming: true,
    parking_available: true,
    paid_parking: true,
    description: "Premier outdoor facility near the beach with heated lanes."
  },
  {
    name: "Community Recreation Pool",
    address: "789 Park Blvd",
    city: "Oakland",
    state: "CA",
    zip_code: "94610",
    latitude: 37.8044,
    longitude: -122.2712,
    length_value: 25,
    length_unit: "meters",
    total_lanes: 4,
    verified: false,
    indoor: true,
    outdoor: false,
    has_photos: false,
    open_stall_showers: true,
    private_showers: false,
    day_lockers: true,
    byol_lockers: true,
    membership_type: "public",
    day_pass_available: true,
    price_per_hour: 10.00,
    lifeguard_on_duty: false,
    pull_buoy_available: false,
    kickboard_available: true,
    fins_available: false,
    has_coaches: false,
    accessible: true,
    masters_swimming: false,
    parking_available: true,
    paid_parking: false,
    description: "Affordable community pool with friendly staff."
  },
  {
    name: "Elite Swim Academy",
    address: "321 Victory Ln",
    city: "San Jose",
    state: "CA",
    zip_code: "95113",
    latitude: 37.3382,
    longitude: -121.8863,
    length_value: 25,
    length_unit: "yards",
    total_lanes: 10,
    verified: true,
    indoor: true,
    outdoor: true,
    has_photos: true,
    open_stall_showers: true,
    private_showers: true,
    day_lockers: true,
    byol_lockers: false,
    membership_type: "private",
    day_pass_available: false,
    price_per_hour: 30.00,
    lifeguard_on_duty: true,
    pull_buoy_available: true,
    kickboard_available: true,
    fins_available: true,
    has_coaches: true,
    accessible: true,
    masters_swimming: true,
    parking_available: true,
    paid_parking: false,
    description: "Professional training facility for serious swimmers."
  },
  {
    name: "Marina Fitness Pool",
    address: "555 Harbor Dr",
    city: "San Francisco",
    state: "CA",
    zip_code: "94123",
    latitude: 37.8024,
    longitude: -122.4381,
    length_value: 25,
    length_unit: "yards",
    total_lanes: 5,
    verified: true,
    indoor: true,
    outdoor: false,
    has_photos: true,
    open_stall_showers: true,
    private_showers: true,
    day_lockers: true,
    byol_lockers: true,
    membership_type: "public",
    day_pass_available: true,
    price_per_hour: 18.00,
    lifeguard_on_duty: true,
    pull_buoy_available: true,
    kickboard_available: true,
    fins_available: false,
    has_coaches: false,
    accessible: true,
    masters_swimming: false,
    parking_available: false,
    paid_parking: false,
    description: "Part of a full-service fitness center near the Marina."
  }
]

pools_data.each do |pool_data|
  pool = Pool.create!(pool_data)
  puts "Created pool: #{pool.name}"
  
  (0..13).each do |days_ahead|
    date = Date.current + days_ahead.days
    
    [6, 7, 8, 9, 10, 11].each do |hour|
      pool.availability_slots.create!(
        slot_date: date,
        start_time: Time.parse("#{hour}:00"),
        end_time: Time.parse("#{hour}:30"),
        available_lanes: rand(1..pool.total_lanes)
      )
      pool.availability_slots.create!(
        slot_date: date,
        start_time: Time.parse("#{hour}:30"),
        end_time: Time.parse("#{hour + 1}:00"),
        available_lanes: rand(1..pool.total_lanes)
      )
    end
    
    [12, 13, 14, 15, 16, 17, 18, 19, 20, 21].each do |hour|
      pool.availability_slots.create!(
        slot_date: date,
        start_time: Time.parse("#{hour}:00"),
        end_time: Time.parse("#{hour}:30"),
        available_lanes: rand(1..pool.total_lanes)
      )
      pool.availability_slots.create!(
        slot_date: date,
        start_time: Time.parse("#{hour}:30"),
        end_time: Time.parse("#{hour + 1}:00"),
        available_lanes: rand(1..pool.total_lanes)
      )
    end
  end
  
  puts "  Created availability slots for #{pool.name}"
end

puts "\nPool seeding complete!"
puts "Created #{Pool.count} pools"
puts "Created #{AvailabilitySlot.count} availability slots"
