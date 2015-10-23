module GrapeSlate
  module Generators
    class Document < Base
      def initialize(namespace, routes)
        self.namespace = namespace
        self.routes = routes
      end

      def generate
        namespace_array = []
        namespace_array << content_tag(:h1, title)

        routes.map do |route|
          namespace_array << content_tag(:h2, route.route_description)
          namespace_array << route.route_detail
          namespace_array << Request.new(route.route_method, route.route_path).generate
          namespace_array << Parameters.new(route.route_params, route.route_method).generate
        end

        namespace_array
      end

      def title
        namespace.split('/').last.capitalize
      end

      private

      attr_accessor :namespace, :routes
    end
  end
end
