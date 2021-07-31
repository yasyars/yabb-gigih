require_relative '../../controller/item_controller.rb'
require './models/item'
require_relative '../../controller/category_controller.rb'
require './models/category'

describe CategoryController do
  before [:each] do
    client = create_db_client
    client.query("SET FOREIGN_KEY_CHECKS = 0")
    client.query("TRUNCATE TABLE item_categories")
    client.query("TRUNCATE TABLE items")
    client.query("TRUNCATE TABLE categories")
    client.query("SET FOREIGN_KEY_CHECKS =1")
    
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

  describe '#create_item' do
    
    context 'when given valid params' do
      before [:each] do
        controller = ItemController.new
        params = {
          "name" => "Banana",
          "price" => "15000",
          "category_ids" => ["1","2"]
        }
        @response= controller.create_item(params)
      end
      it 'should save item' do
        expected_item = Item.find(1)
        expect(expected_item).not_to be_nil
      end

      it 'should return right view' do
        expected_view = ERB.new(File.read("./views/index.erb")).result_with_hash({
          items: [Item.new({
            id: "1",
            name: "Banana",
            price: "15000",
            categories: [@category1,@category2]
          })]
        })
        expect(@response).to eq(expected_view)
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

  describe '#edit_item_form' do
    before [:each] do
      controller = ItemController.new
      item = Item.new({
        name: "Banana",
        price: "15000",
        categories: [@category1]
      })
      item.save
    end

    context 'when given valid params' do
      it 'should return view' do
        params = {
          'item_id' => "1",
        }

        controller = ItemController.new
        response = controller.edit_item_form(params)
        expected_view = ERB.new(File.read("./views/edit.erb")).result_with_hash({
          item: Item.new({
            id: "1",
            name: "Banana",
            price: "15000",
            categories: [@category1]
          }),
          categories: Category.find_all
        })
        expect(response).to eq(expected_view)
      end
    end
  end

  describe '#show_item_detail' do
    before [:each] do
      controller = ItemController.new
      item = Item.new({
        name: "Banana",
        price: "15000",
      })
      item.save
    end

    context 'when given valid params' do
      it 'should return view' do
        params = {
          'item_id' => "1",
        }

        controller = ItemController.new
        response = controller.show_item_detail(params)
        expected_view = ERB.new(File.read("./views/detail.erb")).result_with_hash({
          item:  Item.new({
            id: "1",
            name: "Banana",
            price: "15000"
          })  
        })
        
        expect(response).to eq(expected_view)

      end
    end
  end


  describe '#update_item' do
    before [:each] do
      controller = ItemController.new
      item = Item.new({
        name: "Banana",
        price: "15000",
      })
      item.save
    end

    context 'when the parameter is valid' do
      it 'should return true' do
        controller = ItemController.new
        params = {
            'item_id' => "1",
            'name' => "Pisang",
            'price' => "20000",
            'category_ids' => ["1"]
          }
        controller.update_item(params)
      end
    end

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

  describe '#delete_item' do
    before [:each] do
      controller = ItemController.new
      item = Item.new({
        name: "Banana",
        price: "15000",
      })
      item.save
    end

    context 'when delete item' do
      it 'should remove item' do
        controller = ItemController.new
        params = {
          "item_id" => "1"
        }

        controller.delete_item(params)
        expect(Item.find(1)).to be(false)
      end
    end
  end
end
    