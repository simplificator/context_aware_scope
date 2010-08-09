class Order < ActiveRecord::Base
  belongs_to :customer
end

class Customer < ActiveRecord::Base
  has_many    :orders
  belongs_to  :city
end

class City < ActiveRecord::Base
  has_many    :customers
end

def setup_database(name)
  database_yml = YAML.load_file(File.join(File.dirname(__FILE__), 'database.yml'))
  ActiveRecord::Base.establish_connection(database_yml[name])
  ActiveRecord::Base.configurations = true

  ActiveRecord::Schema.verbose = false
  ActiveRecord::Schema.define(:version => 1) do
    create_table :orders do |t|
      t.string  :product_name
      t.integer :price
      t.date    :purchased_at
      t.integer :customer_id
    end

    create_table :customers do |t|
      t.string  :name
      t.integer :credit
      t.integer :city_id
    end

    create_table :cities do |t|
      t.string  :name
    end
  end
end

def seed_models
  city1 = City.create(:name => 'Zurich')
  city2 = City.create(:name => 'Basel')
  customer1 = Customer.create(:name => 'Aladin', :city => city1)
  customer2 = Customer.create(:name => 'Ali Baba', :city => city1)
  customer3 = Customer.create(:name => 'Sidi Abdel', :city => city2)
  order1 = Order.create(:customer => customer1, :product_name => 'magic carpet', :price => 500, :purchased_at => '2010-07-22')
  order2 = Order.create(:customer => customer1, :product_name => 'old lamp', :price => 5, :purchased_at => '2010-07-22')
  order3 = Order.create(:customer => customer2, :product_name => 'camel', :price => 1200, :purchased_at => '2010-07-24')
end

def cleanup_database
  City.delete_all
  Customer.delete_all
  Order.delete_all
end