require './models/item'
require './db/db_connector'

describe Item do
  before [:each] do
    client = create_db_client
    client.query("SET FOREIGN_KEY_CHECKS = 0")
    client.query("TRUNCATE TABLE orders")
    client.query("TRUNCATE TABLE items")
    client.query("SET FOREIGN_KEY_CHECKS =1")
  end

  describe '#valid?' do
    context 'when initialized with valid input' do
      it 'should return true' do
        item = Item.new({
          name: "Mango",
          price: "20000",
        })
        expect(item.valid?).to eq(true)
      end
    end
  end

  describe '#save' do
    context 'when add new item' do
      it 'should return the item' do
        item = Item.new({
          id: "4",
          name: "Apple",
          price: "15000"
        })
        item.save
      end
    end
  end

 

  
end