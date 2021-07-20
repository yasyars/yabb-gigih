require 'mysql2'
require_relative 'category'
require_relative 'item'

def create_db_client
  client = Mysql2::Client.new(
    :host => "localhost",
    :username => "root",
    :pasword => "",
    :database => "food_oms_db"
  )
  client
end

def get_all_items
  client = create_db_client
  rawData = client.query("select * from items")
  items = Array.new
  rawData.each do |data|
    item = Item.new(data["id"], data["name"], data["price"])
    items.push(item)
  end
  items
end

def get_all_categories
  client = create_db_client
  rawData = client.query("select * from categories")
  categories = Array.new
  rawData.each do |data|
    category = Category.new(data["id"], data["name"])
    categories.push(category)
  end
end

def get_all_items_categories
  client = create_db_client
  rawData = client.query("SELECT DISTINCT items.id, items.name , items.price, categories.id AS category_id, categories.name AS categories_name 
  FROM items 
  JOIN item_categories ON items.id = item_categories.item_id 
  JOIN categories ON item_categories.category_id = categories.id")
  items = Array.new
  rawData.each do |data|
    category = Category.new(data["category_id"], data["category_name"])
    item = Item.new(data["id"], data["name"], data["price"], category)
    items.push(item)
  end
end

def insert_item(name, price)
  client = create_db_client
  client.query("INSERT INTO items (name,price) VALUES ('#{name}', '#{price}')")
end

def insert_item_with_category(name, price,category_id)

  client = create_db_client
  client.query("INSERT INTO items (name,price) VALUES ('#{name}', '#{price}')")
  item_id = client.last_id
  puts ("paspdap #{category_id}")
  client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{item_id}', '#{category_id}')")
end

# def get_cheaper_item(price)
#   client = create_db_client
#   query = "select * from items where price < #{price}"
#   items = client.query(query)
# end
