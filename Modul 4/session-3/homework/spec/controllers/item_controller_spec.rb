require_relative '../../controller/item_controller.rb'
require './models/item'

describe ItemController do
  describe '#list_items' do
    context 'when initialized'do 
      it 'should return item page'do
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
      it 'returns false' do
        controller = ItemController.new
        params = {
          'item_id' => "",
          'name' => "",
          'price' => "",
          'category_ids' => []
        }

        expect{controller.update_item(params)}.to raise_error
      end
    end
  end
end
    