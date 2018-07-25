class Pantry
  attr_reader :stock,
              :shopping_list,
              :cookbook
  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
  end

  def stock_check(food)
    @stock[food]
  end

  def restock(food, amount)
    @stock[food] = amount
  end

  def add_to_shopping_list(list)
    @shopping_list = list.ingredients
  end

  def print_shopping_list
    @shopping_list.inject("") do |string, hash|
      string + "* #{hash[0]}: #{hash[1]}" + "\n"
    end.chomp
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    # binding.pry
    @cookbook.find_all do |ingredient|
      @stock.any? == ingredient.ingredients

    end

  end

end
