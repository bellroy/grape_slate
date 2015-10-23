require "grape_slate/version"
require "grape_slate/configuration"
require "grape_slate/generators"
require "grape_slate/documentation_generator"

module GrapeSlate
  def self.root
    File.dirname __dir__
  end
end
