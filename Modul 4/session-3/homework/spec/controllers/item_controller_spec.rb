require_relative '../../controller/item_controller.rb'
require './models/item'

describe ItemController do
  before [:each] do
    client = create_db_client
    client.query("SET FOREIGN_KEY_CHECKS = 0")
    client.query("TRUNCATE TABLE item_categories")
    client.query("TRUNCATE TABLE items")
    client.query("TRUNCATE TABLE categories")
    client.query("SET FOREIGN_KEY_CHECKS =1")
    @category1 = Category.new({
      id:"1",
      name: "Main Dish"})
    @category1.save
    @category2 = Category.new({
      id: "2",
      name: "Beverage"})
    @category2.save
  end
  
  describe '#create_item_form' do
    context 'when initialize' do
      it 'should return view' do
        controller = ItemController.new
        response = controller.create_item_form
        categories = 
        expected_view = ERB.new(File.read("./views/create.erb")).result_with_hash(
        {
          categories: [@category1, @category2]
        })

        expect(response).to eq(expected_view)
      end
    end
  end

  describe '#list_items' do
    context 'when initialized'do 
      it 'should return item view'do
        controller = ItemController.new
        response = controller.list_items
        expected_view = ERB.new(File.read("./views/index.erb")).result_with_hash(
          {
            items: Item.find_all
          }
        )
        expect(response).to eq(expected_view)
      end
    end
  end 

  describe '#update_item' do

    context 'when the parameter is invalid' do
      it 'returns error' do
        controller = ItemController.new
        params = {
          'item_id' => "",
          'name' => "",
          'price' => "",
          'category_ids' => []
        }

        expect{controller.update_item(params)}.to raise_error(TypeError)
      end
    end
  end
end
    