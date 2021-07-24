require_relative '../db/db_connector'
require_relative 'category'

class Item
  attr_reader :id, :name, :price, :categories
  
  def initialize(id, name, price, categories=[])
    @id=id
    @name=name
    @price =price
    @categories =categories
  end
 
  def self.find(item_id)
    client = create_db_client
    query = "SELECT DISTINCT items.id, items.name , items.price FROM items WHERE items.id = #{item_id}"
    data = client.query(query).first
    categories = Category.find_by_item_id(data["id"])
    item = Item.new(data["id"], data["name"], data["price"], categories)
    item
  end

  def self.find_by_category(category)
    client = create_db_client
    items = Array.new
    rawData = client.query("
      SELECT DISTINCT items.id, items.name, items.price FROM item_categories
      JOIN items ON item_categories.item_id = items.id
      WHERE item_categories.category_id = #{category.id}")
    rawData.each do |data|
      item = Item.new(data["id"],data["name"],data["price"])
      items.push(item)
    end
    items
  end

  def self.find_all
    client = create_db_client
    rawData = client.query("SELECT * FROM items")
    items = Array.new
    rawData.each do |data|
      item = Item.new(data["id"], data["name"], data["price"])
      items.push(item)
    end
    items
  end

  def save
    client = create_db_client
    client.query("INSERT INTO items (name,price) VALUES ('#{@name}', '#{@price}')")
    item = Item.find(client.last_id)
    item
  end
 

  def save_with_category
    return false unless valid?
    client = create_db_client
    item = self.save
    @categories.each do |category|
      item.add_category(category)
    end
  end

  def delete_categories_from_item
    client = create_db_client
    client.query("DELETE FROM item_categories WHERE item_id = #{@id}")
  end

  def delete_category_from_item(category)
    client = create_db_client
    client.query("DELETE FROM item_categories WHERE item_id=#{@id} AND category_id=#{category.id}")
  end

  def add_category(category)
    client = create_db_client
    client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{@id}', '#{category.id}')")
  end


  def update(new_name, new_price, new_categories)
    client = create_db_client
    delete_categories_from_item
    new_categories.each do |new_category|
      client.query("INSERT INTO item_categories (item_id, category_id) VALUES(#{@id}, #{new_category.id})")
    end
  end


  def destroy
    client = create_db_client
    delete_categories_from_item
    client.query("DELETE FROM order_details WHERE item_id = #{@id}")
    client.query("DELETE FROM items WHERE id = #{@id}")
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    return true
  end

end