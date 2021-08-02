require './controller/item_controller.rb'
require './models/item'
require './controller/category_controller.rb'
require './models/category'
require './db/db_connector'

##test untuk CRUD & validation utama model ITEM

describe Item do
  before [:each] do
    client = create_db_client
    client.query("SET FOREIGN_KEY_CHECKS = 0")
    client.query("TRUNCATE TABLE item_categories")
    client.query("TRUNCATE TABLE items")
    client.query("SET FOREIGN_KEY_CHECKS =1")
    client.close
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
      it 'should return true' do
        item = Item.new({
          name: "Mango",
          price: "15000"
        })
        item.save
      end
    end
  end

  describe '#find' do
    before [:each] do
      item = Item.new(
        name: "Apple",
        price: "15000"
      )
      @item_expected = item.save
    end

    context 'when find exist item' do
      it 'should return the right item' do
        item = Item.find(1)
        expect(item.id).to eq(@item_expected.id)
        expect(item.name).to eq(@item_expected.name)
        expect(item.price).to eq(@item_expected.price)
      end
    end

    context 'when find non-exist item' do
      it 'should return false ' do
        item = Item.find(55)
        expect(item).to be(false)
      end
    end
  end

  describe '#find_all' do
    context 'when there are items' do
      before [:each] do
        item = Item.new(
          name: "Apple",
          price: "15000"
        )
        item2 = Item.new(
          name: "Mango",
          price: "10000"
        )
        @item_expected1 = item.save
        @item_expected2 = item2.save
        @items = Item.find_all
      end

      it 'should return the right size' do
        expect(@items.size).to eq(2)
      end

      it 'should return the right items' do
        expect(@items[0].name).to eq(@item_expected1.name)
        expect(@items[0].price).to eq(@item_expected1.price)
        expect(@items[1].name).to eq(@item_expected2.name)
        expect(@items[1].price).to eq(@item_expected2.price)
      end
    end

    context 'when there are no items' do
      it 'should return empty array ' do
        item = Item.find_all
        expect(item).to eq([])
      end
    end
  end

  describe '#update' do
    

    context 'when given valid attribute' do
      before [:each] do
        item = Item.new(
          name: "Apple",
          price: "15000"
        )
        item.save
      end
      it 'should return true' do
        item = Item.find(1)        
        item.update("Mango","20000")

        item_result = Item.find(1)

        expect(item.name).to eq(item_result.name)
        expect(item.price).to eq(item_result.price)
      end
    end

    context 'when given invalid attribute' do
      before [:each] do
        item = Item.new(
          name: "Apple",
          price: "15000"
        )
        item.save
      end
      it 'should return false' do
        item = Item.find(1)   
        expect(item.update("","")).to be(false)
      end
    end
  end

  describe "#delete" do
    before [:each] do
      item = Item.new(
        name: "Apple",
        price: "15000"
      )
      item.save
    end

    context 'when delete exist item' do
      it 'should return true' do 
        item = Item.find(1)
        item.delete
      end
    end
    
  end
end