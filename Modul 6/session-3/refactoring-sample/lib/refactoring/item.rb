module Refactoring
  class Item
    attr_reader :name, :price, :type, :stock, :tags

    def initialize(type, name, price, stock, tags)
      type_valid = validate_type(type)
      tags_valid = validate_tags(type, tags)
      if type_valid and tags_valid
        @type = type
        @name = name
        @price = price
        @stock =  stock
        @tags = tags
      else
        raise ArgumentError
      end
    end
    
    def returnable?
      false
    end

    def tax_in_percent
      0
    end

    def validate_type(type)
      ['BookItem', 'EelctronicItem', 'FoodItem', 'DrinkItem', 'SnackItem'].include?(type)
    end

    def validate_tags(type, tags)
      raise NotImplementedError
    end
  end

  class BookItem < Item
    def initialize
      type = 'BookItem'
      super(type, name, price, stock, tags)
    end

    def validate_tags(tags)
      ['children', 'teen', 'adult', 'fiction', 'non-fiction'].include?(tags)
    end

    def tax_in_percent
      10
    end

    def returnable?
      true
    end
  end

  class EelctronicItem < Item
    def initialize
      type = 'EelctronicItem'
      super(type, name, price, stock, tags)
    end

    def validate_tags(tags)
      ['household','office','hobby','sports'].include?(tags)
    end

    def tax_in_percent
      15
    end

    def returnable?
      true
    end
  end

  class DrinkItem < Item
    def initialize
      type = 'DrinkItem'
      super(type, name, price, stock, tags)
    end

    def validate_tags(tags)
      ['dairy', 'vegetable', 'fruit', 'coffee', 'tea'].include?(tags)
    end

    def tax_in_percent
      5
    end
  end

  class FoodItem < Item
     def initialize
      type = 'FoodItem'
      super(type, name, price, stock, tags)
    end

    def validate_tags(tags)
      ['meat', 'dairy', 'vegetable', 'fruit', 'pastry'].include?(tags)
    end

    def tax_in_percent
      5
    end
  end

  class SnackItem < Item
    def initialize
      @type = 'SnackItem'
    end

    def validate_tags(tags)
      ['meat', 'dairy', 'vegetable', 'fruit', 'pastry'].include?(tags)
    end

    def tax_in_percent
      5
    end
  end
end
