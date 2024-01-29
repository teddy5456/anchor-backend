# db/seeds.rb

# Creating InventoryItems
item1 = InventoryItem.create!(
  name: 'Item 1',
  description: 'Description of Item 1',
  quantity: 10,
  price: 19.99,
  units_per_box: 5,
  date_arrival: DateTime.now
)

item2 = InventoryItem.create!(
  name: 'Item 2',
  description: 'Description of Item 2',
  quantity: 15,
  price: 29.99,
  units_per_box: 8,
  date_arrival: DateTime.now
)

# Seed data for Releases
release1 = Release.create!(
  client_name: 'Client A',
  order_ref: 'Order 123',
  location: 'Warehouse A',
  inventory_items_attributes: [
    { name: 'Item 1', description: 'Description for Item 1', quantity: 10, price: 19.99, units_per_box: '5 units', date_arrival: Date.today },
    { name: 'Item 2', description: 'Description for Item 2', quantity: 15, price: 29.99, units_per_box: '8 units', date_arrival: Date.today }
  ]
)

release2 = Release.create!(
  client_name: 'Client B',
  order_ref: 'Order 456',
  location: 'Warehouse B',
  inventory_items_attributes: [
    { name: 'Item 3', description: 'Description for Item 3', quantity: 20, price: 24.99, units_per_box: '7 units', date_arrival: Date.today },
    { name: 'Item 4', description: 'Description for Item 4', quantity: 12, price: 34.99, units_per_box: '10 units', date_arrival: Date.today }
  ]
)

# Creating Joins
Join.create!(release: release1, inventory_item: item1)
Join.create!(release: release2, inventory_item: item1)

