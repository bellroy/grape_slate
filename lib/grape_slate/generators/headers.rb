module GrapeSlate
  module Generators
    class Headers
      def initialize(route_headers)
        self.route_headers = route_headers
      end

      def generate
        array = []

        if route_headers.present?
          array << "### Request Headers"
          array << "Header | Required / Values | Description"
          array << "--------- | ----------------- | -----------"
          array << route_headers.map {|k,v| [k, "`#{v[:required]}` #{v[:values]}", v[:description]].join(' | ') unless v.is_a?(String) }.compact
        end

        return array.join("\n")
      end

      private

      attr_accessor :route_headers
    end
  end
end
