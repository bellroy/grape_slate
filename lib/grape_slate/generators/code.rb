require 'json'

module GrapeSlate
  module Generators
    class Code < Base
      def initialize(route)
        self.route = route
      end

      def generate
        array = []
        array << code_sample
        array << response_sample
        array.join("\n")
      end

      private

      attr_accessor :route

      def json_data
        route.route_params.map { |k,v| [k, v[:documentation][:example]] unless v.is_a?(String) || v[:documentation].blank? }.compact.to_h.to_json
      end

      def code_sample
        array = []
        array << "```shell\n"
        array << "curl #{documentable_route_path(route)}"
        array << "--request #{route.route_method}"
        array << "--data '#{json_data}'"
        array << route_headers
        array << "--verbose\n"
        array << "```\n"
        array.join(' ')
      end

      def route_headers
        headers = Headers.new(route.route_headers)
        {
          'Content-Type' => 'application/json'
        }.merge(headers.route_header_examples).map do |key, value|
          "--header '#{key}: #{value}'"
        end.join(" ").strip
      end

      def response_sample
        example_response = route.route_settings[:example_response]
        unless example_response.nil?
          array = []
          array << "> Example Response\n"
          array << "```json"
          array << JSON.pretty_generate(example_response.map {|k,v| [k, v[:example]] }.to_h)
          array << "```"
          array.join("\n")
        end
      end
    end
  end
end
