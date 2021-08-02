require './controller/item_controller.rb'
require './models/item'
require './controller/category_controller.rb'
require './models/category'
require './db/db_connector'
##test untuk CRUD & validation utama model Category

describe Category do
  before [:each] do
    client = create_db_client
    client.query("SET FOREIGN_KEY_CHECKS = 0")
    client.query("TRUNCATE TABLE items")
    client.query("TRUNCATE TABLE item_categories")
    client.query("TRUNCATE TABLE categories")
    client.query("SET FOREIGN_KEY_CHECKS =1")
    client.close
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
    context 'when find exist category' do
      it 'should return the right category' do
        category = Category.new({
         name: "Main Dish",
         })
      
        expected_category = category.save
        category = Category.find(1)
        expect(category.id).to eq(expected_category.id)
        expect(category.name).to eq(expected_category.name)
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
      before (:example) do
        @category1 = Category.new(
          id: "1",
          name: "Main Dish"
        )

        @category2 = Category.new(
          id: "2",
          name: "Beverages"
        )

        @category1.save
        @category2.save
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

  describe '#update' do
    before [:each] do
      category = Category.new(
        name: "Main Dish",
      )
      category.save
    end

    context 'when given valid attribute' do
      it 'should return true' do
        category = Category.find(1)        
        category.update("Dinner")
        category_result = Category.find(1)
        expect(category.name).to eq(category_result.name)
      end
    end

    context 'when given invalid attribute' do
      it 'should return false' do
        category = Category.find(1)   
        expect(category.update("")).to be(false)
      end
    end
  end

  describe 'delete'do
     before [:each] do
      category = Category.new(
        name: "Main Dish",
      )
      category.save
    end

    context 'when delete exist item' do
      it 'should return true' do 
        category = Category.find(1)
        category.delete
      end
    end
    
  end
end