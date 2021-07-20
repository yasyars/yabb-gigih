require 'sinatra'
require_relative './db_connector'

get '/' do
  # items = get_all_items
  items = get_all_items_categories
  erb :index, locals: {
    items: items
  }
end

get '/items/new' do 
  categories = get_all_categories
  erb :create, locals: {
    categories: categories
  }
end

post '/items/create' do
  name = params['name']
  price= params['price']
  category_id = params['category_id']
  insert_item_with_category(name,price,category_id)
  redirect '/'
end