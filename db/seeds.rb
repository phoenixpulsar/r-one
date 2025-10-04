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
