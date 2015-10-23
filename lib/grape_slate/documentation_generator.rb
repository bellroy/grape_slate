module GrapeSlate
  class DocumentationGenerator
    def initialize(api_class)
      self.api_class = api_class
    end

    def run!
      namespaces.each do
        Document.new(namespace, routes_for(namespace)).generate
      end
    end

    def namespaces
      api_class.routes.map(&:route_namespace).uniq
    end

    private

    attr_accessor :api_class

    def routes_for(namespace)
      api_class.routes.select { |route| route.route_namespace == namespace }
    end
  end
end
