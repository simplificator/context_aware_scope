require 'test_helper'

class NormalScopeTest < Test::Unit::TestCase
  context 'orders' do
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
        assert_equal Hash, @orders.context.class
        assert_equal ({:price => '> 10'}), @orders.context
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
        assert_equal Hash, @orders.context.class
        assert_equal 2, @orders.context.size
        assert_equal '> 10', @orders.context[:price]
        assert_equal 'camel', @orders.context[:product]

      end
    end
  end
end
