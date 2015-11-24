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
          namespace_array << Code.new(route).generate
          namespace_array << route.route_detail if route.route_detail.present?
          namespace_array << Request.new(route).generate
          namespace_array << Headers.new(route.route_headers).generate
          namespace_array << Parameters.new(route.route_params, route.route_method).generate
        end

        namespace_array
      end

      def filename
        namespace.split('/').last
      end

      private

      attr_accessor :namespace, :routes

      def title
        filename.titleize
      end
    end
  end
end
