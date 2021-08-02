require './models/item'
require './models/category'

class ItemController
 
  def create_item_form
    categories = Category.find_all
    renderer = ERB.new(File.read("./views/create.erb"))
    renderer.result(binding)
  end

  def create_item(params)
    category_ids= params['category_ids']
    categories = Category.find_by_list_id(category_ids)
    item = Item.new({
      name: params['name'],
      price: params['price'],
      categories: categories
    })
    item.save_with_category
    list_items
  end

   def list_items
    items = Item.find_all
    renderer = ERB.new(File.read("./views/index.erb"))
    renderer.result(binding)
  end

  
  def edit_item_form(params)
    categories = Category.find_all
    item_id = params['item_id']
    item = Item.find(item_id)
    categories = Category.find_all
    renderer = ERB.new(File.read("./views/edit.erb"))
    renderer.result(binding)
  end


  def show_item_detail(params)
    item_id = params['item_id']
    item = Item.find(item_id)
    renderer = ERB.new(File.read("./views/detail.erb"))
    renderer.result(binding)
  end

  def update_item(params)
    item_id = params['item_id']
    name = params['name']
    price = params['price']
    category_ids = params['category_ids']
    categories = Category.find_by_list_id(category_ids)
    item = Item.find(item_id)
    item.update(name, price,categories)
  end

  def delete_item(params)
    item_id = params['item_id']
    item = Item.find(item_id)
    item.delete
  end

end