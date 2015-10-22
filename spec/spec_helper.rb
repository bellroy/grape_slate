$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require 'grape'
require 'grape_slate'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
