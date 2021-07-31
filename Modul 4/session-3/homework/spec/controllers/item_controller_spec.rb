require_relative '../../controller/item_controller.rb'

describe ItemController do
  describe '#list_items' do
    context 'when initialized'do 
      it 'should return item page'do
        controller = ItemController.new
        response = controller.list_items

        expected_view = ERB.new(File.read("./views/index.erb").result_with_hash(

        ))
        expect(response).to eq(expected_view.result)
      end
    end
  end

  describe '#update' do
    context 'when the parameter is invalid' do
      it 'returns false' do
        subject = Item.new({})

        expect(subject.update).to eq false
      end
    end
end
    