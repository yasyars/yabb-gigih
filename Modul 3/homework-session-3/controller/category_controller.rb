require './models/category'

class CategoryController
  def list_categories
    categories = Category.find_all
    items = Item.find_all
    item_id = 0
    renderer = ERB.new(File.read("./views/categories.erb"))
    renderer.result(binding)
  end

  def show_items(params)
    category = Category.find_with_items(params["category_id"])
    renderer = ERB.new(File.read("./views/category_detail.erb"))
    renderer.result(binding)
  end

  def edit_form(params)
    category = Category.find_with_items(params["category_id"])
    items = Item.find_all
    renderer = ERB.new(File.read("./views/category_edit.erb"))
    renderer.result(binding)
  end

  def edit(params)
    category = Category.find(params["category_id"])
    category.update(params["name"])
  end

  def delete_from_item(params)
    category = Category.find(params["category_id"])
    category.delete_from_item(params["item_id"])
  end

  def add_item(params)
    category = Category.find(params["category_id"])
    category.add_item(params["item_id"])
  end

  def delete_category(params)
    category = Category.find_with_items(params["category_id"])
    category.destroy
  end

  def create_category(params)
    category = Category.new({
      name: params["name"]})
    category = category.save
    category
  end

  def create_category_form
    renderer = ERB.new(File.read("./views/category_add.erb"))
    renderer.result(binding)
  end

  def find_by_item_id(params)
    categories = Category.find_by_item_id(params["item_id"])
    items = Item.find_all
    item_id = params["item_id"].to_i
    renderer = ERB.new(File.read("./views/categories.erb"))
    renderer.result(binding)
  end

end