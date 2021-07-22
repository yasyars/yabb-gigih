require_relative '../db/db_connector'

class Item
  attr_reader :id, :name, :price, :category
  
  def initialize(id, name, price, category=nil)
    @id=id
    @name=name
    @price =price
    @category =category
  end
 
  def self.find(item_id)
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

  def self.get_all_items
    client = create_db_client
    rawData = client.query("select * from items")
    items = Array.new
    rawData.each do |data|
      item = Item.new(data["id"], data["name"], data["price"])
      items.push(item)
    end
    items
  end

  def insert_item_with_category
    return false unless valid?
    puts @category
    client = create_db_client
    client.query("INSERT INTO items (name,price) VALUES ('#{@name}', '#{@price}')")
    item_id = client.last_id
    client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{item_id}', '#{@category.id}')")
  end

  def update_item(new_name, new_price, new_category)
    client = create_db_client
    client.query("UPDATE items SET name='#{new_name}',price='#{new_price}' WHERE items.id=#{@id}")
    item_categories = client.query("SELECT * FROM item_categories WHERE item_id=#{@id}")
    if item_categories.each == []
      client.query("INSERT INTO item_categories (item_id, category_id) VALUES(#{@id}, #{new_category.id})")
    else
      client.query("UPDATE item_categories  SET category_id=#{new_category.id} WHERE item_id = #{@id}")
    end
  end

  def delete
    client = create_db_client
    client.query("DELETE FROM item_categories WHERE item_id = #{@id}")
    client.query("DELETE FROM order_details WHERE item_id = #{@id}")
   
    client.query("DELETE FROM items WHERE id = #{@id}")
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    return true
  end

end