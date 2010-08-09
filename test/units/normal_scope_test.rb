require 'test_helper'

class Order
  named_scope :expensive, :conditions => ['price > ?', 10], :context => 'price > 10'
  named_scope :with_camel, :conditions => {:product_name => 'camel'}, :context => "product_name = camel"
end

class NormalScopeTest < Test::Unit::TestCase
  context 'orders' do #context[:filter] => {:price => '> 10', :product => 'camel'} context[:order]
    setup do
      seed_models
    end

    context 'with a simple scope with text context' do
      setup do
        @orders = Order.expensive
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
        @orders = Order.with_camel.expensive
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
