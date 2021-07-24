require_relative '../db/db_connector'

class Category
  attr_reader :id, :name, :items
  attr_accessor :items

  def initialize(id, name=nil, items=[])
    @id =id
    @name =name
    @items = items
  end

  def self.find_all
    client = create_db_client
    rawData = client.query("SELECT * FROM categories ORDER BY categories.id ASC")
    categories = Array.new
    rawData.each do |data|
      category = Category.new(data["id"], data["name"])
      categories.push(category)
    end
    categories
  end

  def self.find(id)
    client = create_db_client
    rawData = client.query("SELECT * FROM categories WHERE id = #{id}")
    data = rawData.each[0]
    category = Category.new(data["id"],data["name"])
    category
  end

  def self.find_by_name(name)
    client = create_db_client
    rawData = client.query("SELECT * FROM categories WHERE name= '#{name}'")
    data = rawData.each[0]
    category = Category.new(data["id"],data["name"])
    category
  end

  def self.find_by_name_with_items(name)
    category = Category.find_by_name(name)
    items = Item.find_by_category(category)
    category.items = items
    category
  end

  def self.find_with_items(id)
    client = create_db_client
    category = Category.find(id)
    items = Item.find_by_category(category)
    category.items = items
    category
  end

  def self.find_by_list_id(ids)
    client = create_db_client
    list_id= ids.join(',')

    query = "SELECT * FROM categories WHERE id in (#{list_id})"
    puts query
    rawData = client.query(query)
    categories = Array.new
    rawData.each do |data|
      category = Category.new(data["id"], data["name"])
      categories.push(category)
    end
    categories
  end

  def self.find_by_item_id(item_id)
    client = create_db_client
    query_category = "SELECT DISTINCT c.id AS category_id, c.name AS category_name 
    FROM item_categories ic JOIN categories c on ic.category_id = c.id
    WHERE ic.item_id = #{item_id}"
    rawDataCategory = client.query(query_category)
    categories = Array.new
    rawDataCategory.each do |data|
      category = Category.new(data["category_id"], data["category_name"])
      categories.push(category)
    end
    categories
  end

  def update(name)
    client = create_db_client
    query = "UPDATE categories SET name='#{name}' WHERE id = #{@id}"
    client.query(query)
  end

  def delete_from_item(item_id)
    item = Item.find(item_id)
    item.delete_category_from_item(self)
  end

  def add_item(item_id)
    item = Item.find(item_id)
    item.add_category(self)
  end

  def delete_all_items
    @items.each do |item|
      item.delete_category_from_item(self)
    end
  end

  def destroy
    client = create_db_client
    delete_all_items
    client.query("DELETE FROM categories WHERE id= #{@id}")
  end

  def save
    client = create_db_client

    query = "INSERT IGNORE INTO categories (name) VALUES ('#{@name}')"
    client.query(query)
    if client.last_id ==0
      category = Category.find_by_name_with_items(@name)
    else
      category = Category.find_with_items(client.last_id)
    end
    category
  end
end