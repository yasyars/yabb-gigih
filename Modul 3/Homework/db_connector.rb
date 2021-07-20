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

def get_item_details(item_id)
  client = create_db_client
  query = "SELECT DISTINCT items.id, items.name , items.price, categories.id AS category_id, categories.name AS category_name 
  FROM items 
  LEFT JOIN item_categories ON items.id = item_categories.item_id 
  LEFT JOIN categories ON item_categories.category_id = categories.id
  WHERE items.id = #{item_id}"
  data = client.query(query).each[0]
  category = Category.new(data["category_id"], data["category_name"])
  item = Item.new(data["id"], data["name"],data["price"],category)
  item
end


def get_all_categories
  client = create_db_client
  rawData = client.query("select * from categories ORDER BY categories.id ASC")
  categories = Array.new
  rawData.each do |data|
    category = Category.new(data["id"], data["name"])
    categories.push(category)
  end
  categories
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
  items
end

def insert_item(name, price)
  client = create_db_client
  client.query("INSERT INTO items (name,price) VALUES ('#{name}', '#{price}')")
end

def insert_item_with_category(name, price,category_id)

  client = create_db_client
  client.query("INSERT INTO items (name,price) VALUES ('#{name}', '#{price}')")
  item_id = client.last_id
  client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{item_id}', '#{category_id}')")
end

def update_item(item_id,name, price,category_id)

  client = create_db_client
  client.query("UPDATE items SET name='#{name}',price='#{price}' WHERE items.id=#{item_id}")
  item_categories = client.query("SELECT * FROM item_categories WHERE item_id=#{item_id}")
  if item_categories.each == []
    client.query("INSERT INTO item_categories (item_id, category_id) VALUES(#{item_id}, #{category_id})")
  else
    client.query("UPDATE item_categories  SET category_id=#{category_id} WHERE item_id = #{item_id}")
  end
end


def delete_item(item_id)
  client = create_db_client
  client.query("DELETE FROM item_categories WHERE item_id = #{item_id}")
  client.query("DELETE FROM order_details WHERE item_id = #{item_id}")
 
  client.query("DELETE FROM items WHERE id = #{item_id}")
end
