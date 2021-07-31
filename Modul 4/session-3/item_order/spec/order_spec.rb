require './models/order'

describe Order do
  describe '#valid?' do
    context 'when initialized with valid input' do
      it 'should return true' do
        order = Order.new({
          reference_no: "123",
          customer_name: "Alexander Salim",
          date: "2021-07-30"
        })
        expect(order.valid?).to eq(true)
      end
    end
  end
end