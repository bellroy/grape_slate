require 'json'

module GrapeSlate
  module Generators
    class Code < Base
      def initialize(route)
        self.route = route
      end

      def generate
        array = []
        array << "```shell"
        array << code_sample
        array << "```"

        array.join("\n")
      end

      private

      attr_accessor :route

      def json_data
        route.route_params.map { |k,v| [k, v[:documentation][:example]] unless v.is_a?(String) || v[:documentation].blank? }.compact.to_h.to_json
      end

      def code_sample
        array = []
        array << "curl #{documentable_route_path(route)}"
        array << "--request #{route.route_method}"
        array << "--data '#{json_data}'"
        array << "--header 'Content-Type: application/json'"
        array << "--verbose"
        array.join(' ')
      end
    end
  end
end