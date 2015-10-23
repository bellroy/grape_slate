module GrapeSlate
  module Generators
    class Request < Base
      def initialize(route_method, route_path)
        self.route_method = route_method
        self.route_path = route_path
      end

      def generate
        array = []
        array << content_tag(:h3, "HTTP Request")
        array << content_tag(:code, "#{route_method} #{route_path}")
        return array
      end

      private

      attr_accessor :route_method, :route_path
    end
  end
end
