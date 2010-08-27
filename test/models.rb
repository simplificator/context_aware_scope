class Order < ActiveRecord::Base
  belongs_to :customer
  named_scope :by_price, lambda{|price| {:conditions => ['price > ?', price], :context => {:price => "> #{price}"}}}
  named_scope :by_product, lambda{|name| {:conditions => {:product_name => name}, :context => {:product => name}}}
  named_scope :expensive, :conditions => ['price > ?', 10], :context => {:price => '> 10'}
  named_scope :with_camel, :conditions => {:product_name => 'camel'}, :context => {:product => 'camel'}

end

class Customer < ActiveRecord::Base
  has_many    :orders
  belongs_to  :city
  named_scope :by_name, lambda{|name| {:conditions => ['name like ?', "%#{name}%"], :context => {:filter => {:customer => {:name => name}}}}}
end

class City < ActiveRecord::Base
  default_scope :order => 'cities.name ASC', :context => {:order => 'name asc'}
  named_scope   :basel, :conditions => {:name => 'Basel'}, :context => {:name => 'Basel'}

  has_many      :customers
end

class Product < ActiveRecord::Base
  default_scope :order => 'product.id ASC'

  named_scope :luxurious, :conditions => ['price > ?', 100], :context => {:price => 'luxurious'}
  named_scope :recent, :conditions => ['created_at > ?', 1.week.ago], :context => {:created_at => 'brand new'}
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

    create_table :products do |t|
      t.string    :name
      t.datetime  :created_at
      t.integer   :price
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
  product = Product.create(:name => 'Bracelet', :price => 324, :created_at => 1.day.ago)
  product = Product.create(:name => 'Carpet', :price => 12, :created_at => 1.day.ago)
end

def cleanup_database
  [City, Customer, Order, Product].each do |model_class|
    model_class.delete_all
  end
end