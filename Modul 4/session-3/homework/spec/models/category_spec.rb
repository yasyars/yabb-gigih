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

    context 'when initialized with invalid input' do
      it 'should return false' do
        category = Category.new({
        })
        expect(category.valid?).to eq(false)
      end
    end
  end

  describe '#save' do
    context 'when add new category' do
      it 'should return true' do
        category = Category.new({
          name: "Main Dish",
        })
        category.save
      end
    end
  end

  describe '#find' do
    before [:each] do
      category = Category.new({
        name: "Main Dish",
      })
      @expected_category = category.save
    end

    context 'when find exist category' do
      it 'should return the right category' do
        category = Category.find(1)
        expect(category.id).to eq(@expected_category.id)
        expect(category.name).to eq(@expected_category.name)
      end
    end

    context 'when find non-exist item' do
      it 'should return false ' do
        category = Category.find(55)
        expect(category).to be(false)
      end
    end
  end

  describe '#find_all' do
    context 'when there are categories' do
      before [:each] do
        category1 = Category.new(
          name: "Main Dish",
        )

        category2 = Category.new(
          name: "Beverages"
        )

        @category1 = category1.save
        @category2 = category2.save
        @categories = Category.find_all
      end

      it 'should return the right size' do
        expect(@categories.size).to eq(2)
      end

      it 'should return the right items' do
        expect(@categories[0].name).to eq(@category1.name)
        expect(@categories[1].name).to eq(@category2.name)
      end
    end

    context 'when there are no items' do
      it 'should return empty array ' do
        categories = Category.find_all
        expect(categories).to eq([])
      end
    end
  end

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