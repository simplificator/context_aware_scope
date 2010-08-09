require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'leftright'
require 'active_record'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'context_aware_scope'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'context_aware_scope'

#ActiveRecord::Base.logger = Logger.new(STDOUT)
#ActiveRecord::Base.logger.level = Logger::DEBUG

require File.join(File.dirname(__FILE__), 'models')

setup_database('sqlite')

class Test::Unit::TestCase
  def teardown
    cleanup_database
  end
end
