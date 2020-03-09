module GrapeSlate
  module Generators
    class Headers

      def initialize(headers)
        self.headers = headers || {}
      end

      def route_header_examples
        Hash[headers.map { |key, info_hash| [key, info_hash[:documentation][:example]] }]
      end

      def generate
        array = []

        unless headers.empty?
          array << "### Request Headers"
          array << "Header | Required | Values | Description"
          array << "------ | -------- | ------ | -----------"
          array << headers.map do |key,value|
            [
              key,
              "`#{value[:required]}`",
              "`#{value[:values]}`",
              value[:description]
            ].join(' | ') unless value.is_a?(String)
          end.compact
        end

        return array.join("\n")
      end

      private

      attr_accessor :headers
    end
  end
end
