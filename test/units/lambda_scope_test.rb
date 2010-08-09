require 'test_helper'

class Order
  named_scope :by_price, lambda{|price| {:conditions => ['price > ?', 10], :context => "price > #{price}"}}
  named_scope :by_product, lambda{|name| {:conditions => {:product_name => name}, :context => "product_name = #{name}"}}
end

class LambdaScopeTest < Test::Unit::TestCase
  context 'orders' do
    setup do
      seed_models
    end

    context 'with a simple scope with text context' do
      setup do
        @orders = Order.by_price(10)
      end

      should 'should have results' do
        assert_equal 2, @orders.count
      end

      should 'have context on list' do
        assert_equal ActiveRecord::NamedScope::Scope, @orders.class
        assert_equal Array, @orders.context.class
        assert_equal ['price > 10'], @orders.context
      end
    end

    context 'with a chained scope with text context' do
      setup do
        @orders = Order.by_product('camel').by_price(10)
      end

      should 'should have results' do
        assert_equal 1, @orders.count
      end

      should 'set a string context' do
        assert_equal Array, @orders.context.class
        assert_equal ['product_name = camel', 'price > 10'], @orders.context
      end
    end
  end
end
