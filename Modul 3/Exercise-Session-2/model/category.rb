require_relative '../db/db_connector'

class Category
  attr_reader :id, :name

  def initialize(id, name=nil)
    @id =id
    @name =name
  end

  def self.get_all_categories
    client = create_db_client
    rawData = client.query("select * from categories ORDER BY categories.id ASC")
    categories = Array.new
    rawData.each do |data|
      category = Category.new(data["id"], data["name"])
      categories.push(category)
    end
    categories
  end

  def self.find(id)
    client = create_db_client
    rawData = client.query("select * from categories WHERE id = #{id}")
    data = rawData.each[0]
    category = Category.new(data["id"],data["name"])
    category
  end
end