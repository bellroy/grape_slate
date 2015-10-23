module GrapeSlate
  module Generators
    class Parameters
      def initialize(route_params, route_method)
        self.route_params = route_params
        self.route_method = route_method
      end

      def generate
        array = []

        if route_params.present?
          if ['POST', 'PUT', 'PATCH'].include? route_method
            array << "### Request Parameters"
          else
            array << "### Query Parameters"
          end
          array << "Parameter | Type | Required | Description"
          array << "--------- | ---- | -------- | -----------"
          array << route_params.map {|k,v| [k, v[:type].capitalize, "`#{v[:required]}`", v[:desc]].join(' | ') unless v.is_a?(String) }.compact
        end

        return array
      end

      private

      attr_accessor :route_params, :route_method
    end
  end
end
