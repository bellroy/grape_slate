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

      def code_sample
        array = []
        array << "```shell\n"
        array << "curl #{documentable_route_path(route)}"
        array << "--request #{route.request_method}"
        array << "--data '#{param_examples.to_json}'"    unless param_examples.empty?
        array << "--data-binary @#{binary_data_example}" unless binary_data_example.nil?
        array << headers
        array << "--verbose\n"
        array << "```\n"
        array.join(' ')
      end

      def binary_data_example
        route.settings[:example_binary_data]
      end

      def param_examples
        @params_examples ||= route.params.map do |key, value|
          unless value.is_a?(String) || value[:documentation].blank?
            [key, value[:documentation][:example]]
          end
        end.compact.to_h
      end

      def headers
        headers = Headers.new(route.headers)
        {
          'Content-Type' => 'application/json',
          'Authorization' => 'Bearer <YOUR_TOKEN>'
        }.merge(headers.route_header_examples).map do |key, value|
          "--header '#{key}: #{value}'"
        end.join(" ").strip
      end

      def response_sample
        example_response = route.settings[:example_response]
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
