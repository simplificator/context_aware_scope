require 'test_helper'

class DefaultScopeTest < Test::Unit::TestCase
  context 'cities' do
    setup do
      seed_models
    end

    context 'with a default scope' do
      setup do
        @cities = City.scoped({})
      end

      should 'should have results' do
        assert_equal 2, @cities.count
      end

      should 'have context on list' do
        assert_equal ActiveRecord::NamedScope::Scope, @cities.class
        assert_equal Hash, @cities.context.class
        assert_equal ({:order => 'name asc'}), @cities.context
      end
    end

    context 'with a default scope and a named scope' do
      setup do
        @cities = City.basel.scoped({})
      end

      should 'should have results' do
        assert_equal 1, @cities.count
      end

      should 'have context on list' do
        assert_equal ActiveRecord::NamedScope::Scope, @cities.class
        assert_equal Hash, @cities.context.class
        assert_equal ({:order => 'name asc', :name => 'Basel'}), @cities.context
      end
    end
  end
end
