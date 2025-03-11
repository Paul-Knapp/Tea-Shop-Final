# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Clear existing data to avoid duplicates
SubscriptionTea.destroy_all
Subscription.destroy_all
Customer.destroy_all
Tea.destroy_all

# Create Teas
teas = Tea.create!([
  { title: "Green Tea", description: "Light and refreshing", temperature: 80, brew_time: 2 },
  { title: "Black Tea", description: "Bold and strong", temperature: 95, brew_time: 3 },
  { title: "Oolong Tea", description: "Rich and complex", temperature: 90, brew_time: 4 },
  { title: "White Tea", description: "Delicate and smooth", temperature: 75, brew_time: 2 },
  { title: "Herbal Tea", description: "Caffeine-free and soothing", temperature: 90, brew_time: 5 }
])

# Create Customers
customers = Customer.create!([
  { first_name: "Alice", last_name: "Johnson", email: "alice@example.com", address: "123 Main St" },
  { first_name: "Bob", last_name: "Smith", email: "bob@example.com", address: "456 Oak Ave" },
  { first_name: "Charlie", last_name: "Brown", email: "charlie@example.com", address: "789 Pine Rd" },
  { first_name: "Diana", last_name: "Prince", email: "diana@example.com", address: "101 Maple Blvd" },
  { first_name: "Ethan", last_name: "Hunt", email: "ethan@example.com", address: "202 Cedar Ln" }
])

# Create Subscriptions
subscriptions = Subscription.create!([
  { title: "Monthly Green Tea", price: 15.99, status: "active", frequency: "monthly", customer: customers[0] },
  { title: "Biweekly Black Tea", price: 12.99, status: "active", frequency: "biweekly", customer: customers[1] },
  { title: "Weekly Oolong Tea", price: 18.99, status: "cancelled", frequency: "weekly", customer: customers[2] },
  { title: "Monthly White Tea", price: 14.99, status: "active", frequency: "monthly", customer: customers[3] },
  { title: "Herbal Tea Sampler", price: 20.99, status: "cancelled", frequency: "quarterly", customer: customers[4] }
])

# Assign Teas to Subscriptions
SubscriptionTea.create!([
  { subscription: subscriptions[0], tea: teas[0] }, # Green Tea for Alice
  { subscription: subscriptions[1], tea: teas[1] }, # Black Tea for Bob
  { subscription: subscriptions[2], tea: teas[2] }, # Oolong Tea for Charlie
  { subscription: subscriptions[3], tea: teas[3] }, # White Tea for Diana
  { subscription: subscriptions[4], tea: teas[4] }, # Herbal Tea for Ethan
  { subscription: subscriptions[0], tea: teas[2] }, # Alice also gets Oolong Tea
  { subscription: subscriptions[1], tea: teas[3] }, # Bob also gets White Tea
  { subscription: subscriptions[2], tea: teas[4] }, # Charlie also gets Herbal Tea
  { subscription: subscriptions[3], tea: teas[0] }, # Diana also gets Green Tea
  { subscription: subscriptions[4], tea: teas[1] }  # Ethan also gets Black Tea
])

puts "✅ Database successfully seeded with Teas, Customers, Subscriptions, and SubscriptionTeas!"
