require "grape_slate/version"

module GrapeSlate
  autoload :Document, 'grape_slate/document'

  def self.root
    File.dirname __dir__
  end
end
