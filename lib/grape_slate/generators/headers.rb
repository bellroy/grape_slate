module GrapeSlate
  module Generators
    class Headers

      def initialize(route_headers)
        self.route_headers = route_headers || {}
      end

      def route_header_examples
        Hash[route_headers.map { |key, info_hash| [key, info_hash[:documentation][:example]] }]
      end

      def generate
        array = []

        unless route_headers.empty?
          array << "### Request Headers"
          array << "Header | Required / Values | Description"
          array << "------ | ----------------- | -----------"
          array << route_headers.map {|k,v| [k, "`#{v[:required]}` #{v[:values]}", v[:description]].join(' | ') unless v.is_a?(String) }.compact
        end

        return array.join("\n")
      end

      private

      attr_accessor :route_headers
    end
  end
end
