require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test

  def setup
    @pantry = Pantry.new
    @r = Recipe.new("Cheese Pizza")
  end

  def test_pantry_exists
    assert_instance_of Pantry, @pantry
  end

  def test_can_check_stock_starts_with_nothing_stocked
    assert_equal 0, @pantry.stock_check("Cheese")
  end

  def test_it_can_add_food_to_pantry
    @pantry.restock("Cheese", 10)
    actual = {"Cheese" => 10}
    assert_equal @pantry.stock, actual
  end

  def test_restock_can_check_stock_after_food_added_to_pantry
    @pantry.restock("Cheese", 10)
    assert_equal 10, @pantry.stock_check("Cheese")
  end

  def test_add_ingredient_list_to_shopping_list
    @r.add_ingredient("Spaghetti Noodles", 10)
    @r.add_ingredient("Marinara Sauce", 10)
    @r.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(@r)
    expected = {"Spaghetti Noodles"=>10, "Marinara Sauce"=>10, "Cheese"=>5}
    assert_equal expected, @pantry.shopping_list
  end

  def test_print_shopping_list
    @r.add_ingredient("Cheese", 20)
    @r.add_ingredient("Flour", 20)
    @r.add_ingredient("Spaghetti Noodles", 10)
    @r.add_ingredient("Marinara Sauce", 10)
    @r.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(@r)
    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    actual = @pantry.print_shopping_list
    assert_equal expected, actual
  end

  def test_what_can_I_make

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)


    @pantry.add_to_cookbook(r1)
    @pantry.add_to_cookbook(r2)
    @pantry.add_to_cookbook(r3)

    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 120)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)


    assert_equal ["Pickles", "Peanuts"], @pantry.what_can_i_make

  end
end
