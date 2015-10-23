require 'json'

module GrapeSlate
  module Generators
    class Code
      def initialize(route)
        self.route = route
      end

      def generate
        array = []
        array << "```shell"
        array << "curl #{route.route_path} "
        array << "--request #{route.route_method} "
        array << "--data '#{json_data}' "
        array << "--header 'Content-Type: application/json' "
        array << "--verbose"
        array << "```"
      end

      private

      attr_accessor :route

      def json_data
        route.route_params.map { |k,v| [k, v[:documentation][:example]] unless v.is_a?(String) || v[:documentation].blank? }.compact.to_h.to_json
      end
    end
  end
end
