module GrapeSlate
  module Generators
    class Base
      def content_tag(tag, content)
        prefix = case tag
                 when :code
                   '`'
                 when :h1
                   '# '
                 when :h2
                   '## '
                 when :h3
                   '### '
                 else ''
                 end

        suffix = case tag
                 when :code
                   '`'
                 else ''
                 end

        prefix + content + suffix
      end
    end
  end
end

require 'grape_slate/generators/document'
require 'grape_slate/generators/parameters'
require 'grape_slate/generators/request'
