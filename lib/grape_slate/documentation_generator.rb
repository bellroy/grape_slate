module GrapeSlate
  class DocumentationGenerator
    def initialize(api_class)
      self.api_class = api_class
    end

    def run!
      namespaces.each do |namespace|
        document = Generators::Document.new(namespace, routes_for(namespace))
        document_contents = document.generate
        File.open('tmp/'+document.filename+'.md', 'w+') do |file|
          document_contents.each do |content|
            file.write content
            file.write "\n\n"
          end
        end
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
