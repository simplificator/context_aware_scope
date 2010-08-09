require 'test_helper'

class ReadmeSampleTest < Test::Unit::TestCase
  context 'new and luxurious products' do
    setup do
      seed_models
      @products = Product.recent.luxurious
    end

    should 'should have results' do
      assert_equal 1, @products.count
      assert_equal ({:price => 'luxurious', :created_at => 'brand new'}), @products.context
      assert_equal "You are looking at brand new and luxurious products", "You are looking at #{@products.context.values.to_sentence} products"
    end
  end
end
