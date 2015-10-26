module GrapeSlate
  module Generators
    class Request < Base

      # Set GrapeSlate's configuration
      # @param config [Grape::Route]
      def initialize(route)
        self.route = route
      end

      def generate
        array = []
        array << content_tag(:h3, "HTTP Request")
        array << content_tag(:code, "#{route.route_method} #{documentable_route_path(route)}")
        return array.join("\n")
      end

      private

      attr_accessor :route

    end
  end
end
