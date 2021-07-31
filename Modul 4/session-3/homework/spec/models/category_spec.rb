require './models/category'
require './db/db_connector'

##test untuk CRUD & validation utama model Category

describe Category do
  before [:each] do
    client = create_db_client
    client.query("SET FOREIGN_KEY_CHECKS = 0")
    client.query("TRUNCATE TABLE item_categories")
    client.query("TRUNCATE TABLE categories")
    client.query("SET FOREIGN_KEY_CHECKS =1")
  end

  describe '#valid?' do
    context 'when initialized with valid input' do
      it 'should return true' do
        category = Category.new({
          name: "Main Dish",
        })
        expect(category.valid?).to eq(true)
      end
    end
  end

  # describe '#save' do
  #   context 'when add new item' do
  #     it 'should return item' do
  #       item = Item.new({
  #         name: "Mango",
  #         price: "15000"
  #       })
  #       item.save
  #     end
  #   end
  # end

  # describe '#find' do
  #   before [:each] do
  #     item = Item.new(
  #       name: "Apple",
  #       price: "15000"
  #     )
  #     @item_expected = item.save
  #   end

  #   context 'when find exist item' do
  #     it 'should return the right item' do
  #       item = Item.find(1)
  #       expect(item.id).to eq(@item_expected.id)
  #       expect(item.name).to eq(@item_expected.name)
  #       expect(item.price).to eq(@item_expected.price)
  #     end
  #   end

  #   context 'when find non-exist item' do
  #     it 'should return false ' do
  #       item = Item.find(55)
  #       expect(item).to be(false)
  #     end
  #   end
  # end

  # describe '#update' do
  #   before [:each] do
  #     item = Item.new(
  #       name: "Apple",
  #       price: "15000"
  #     )
  #     item.save
  #   end

  #   context 'when given valid attribute' do
  #     it 'should return true' do
  #       item = Item.find(1)        
  #       item.update("Mango","20000")

  #       item_result = Item.find(1)

  #       expect(item.name).to eq(item_result.name)
  #       expect(item.price).to eq(item_result.price)
  #     end
  #   end

  #   context 'when given invalid attribute' do
  #     it 'should return false' do
  #       item = Item.find(1)   
  #       expect(item.update("","")).to be(false)
  #     end
  #   end
  # end

  # describe do
  #   before [:each] do
  #     item = Item.new(
  #       name: "Apple",
  #       price: "15000"
  #     )
  #     item.save
  #   end

  #   context 'when delete exist item' do
  #     it 'should return true' do 
  #       item = Item.find(1)
  #       item.delete
  #     end
  #   end
    
  # end
end