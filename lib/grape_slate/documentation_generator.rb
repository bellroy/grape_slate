module GrapeSlate
  class DocumentationGenerator
    def initialize(api_class)
      self.api_class = api_class
    end

    def run!
      namespaces.each do |namespace|
        document = Generators::Document.new namespace, routes_for(namespace)
        document_contents = document.generate

        File.open(File.join(GrapeSlate.configuration.output_dir, document.filename + file_extension), 'w+') do |file|
          document_contents.each do |content|
            file.write content
            file.write "\n\n"
          end
        end
      end

      return true
    end

    def namespaces
      api_class.routes.map(&:route_namespace).uniq
    end

    private

    attr_accessor :api_class

    def routes_for(namespace)
      api_class.routes.select { |route| route.route_namespace == namespace }
    end

    def file_extension
      '.md'
    end
  end
end
