require 'sinatra'
require './controller/item_controller.rb'
require './controller/category_controller.rb'


get '/' do
  controller = ItemController.new
  controller.list_items
end

#items

get '/items/new' do 
  controller = ItemController.new
  controller.create_item_form
end

get '/items/:item_id/edit' do
  controller = ItemController.new
  controller.edit_item_form(params)
end

post '/items/create' do
  controller = ItemController.new
  controller.create_item(params)
end

get '/items/:item_id' do 
  controller = ItemController.new
  controller.show_item_detail(params)
end

put '/items/:item_id' do
  controller = ItemController.new
  controller.update_item(params)
  redirect "/items/#{params["item_id"]}"
end

delete '/items/:item_id' do
  controller = ItemController.new
  controller.delete_item(params)
  redirect '/'
end

#categories

get '/categories' do
  controller = CategoryController.new

  item_id = params["item_id"] ? params["item_id"] : 0 
  # if item_id == 0
  controller.list_categories
  # else
    # controller.find_by_item_id(item_id)
  # end
end

get '/categories/:category_id' do
  controller = CategoryController.new
  controller.show_items(params)
end

get '/categories/:category_id/edit' do
  controller = CategoryController.new
  controller.edit_form(params)
end

put '/categories/:category_id' do
  controller = CategoryController.new
  controller.edit(params)
  redirect "/categories/#{params['category_id']}"
end

delete '/categories/:category_id/items/:item_id' do
  controller = CategoryController.new
  controller.delete_from_item(params)
  redirect "/categories/#{params["category_id"]}/edit"
end

post '/categories/:category_id/items' do
  controller = CategoryController.new
  controller.add_item(params)
  redirect "/categories/#{params["category_id"]}/edit"
end

delete '/categories/:category_id' do
  controller = CategoryController.new
  controller.delete_category(params)
  redirect "/categories"
end

post '/categories' do
  controller = CategoryController.new
  category = controller.create_category(params)
  redirect "/categories/#{category.id}/edit"
end

get '/add/category' do
  controller = CategoryController.new
  controller.create_category_form
end