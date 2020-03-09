require 'fileutils'

module GrapeSlate
  class DocumentationGenerator
    def initialize(api_class)
      self.api_class = api_class
    end

    def run!
      FileUtils::mkdir_p "#{GrapeSlate.configuration.output_dir}/generated"

      filenames = []

      namespaces.each do |namespace|
        document = Generators::Document.new namespace, routes_for(namespace)
        document_contents = document.generate

        filenames << document.filename

        File.open(File.join(GrapeSlate.configuration.output_dir, 'generated', document.filename + file_extension), 'w+') do |file|
          document_contents.each do |content|
            file.write content
            file.write "\n\n"
          end
        end
      end

      File.open(File.join(GrapeSlate.configuration.output_dir, '_generated.html.erb'), 'w+') do |file|
        file.write "<% docs = #{filenames} %>\n"
        file.write "<% docs.each do |doc| %>\n"
        file.write "  <%= partial \"generated/\#{doc}\" %>\n"
        file.write "<% end %>\n"
      end

      return true
    end

    def namespaces
      api_class.routes.map(&:namespace).uniq
    end

    private

    attr_accessor :api_class

    def routes_for(namespace)
      api_class.routes.select { |route| route.namespace == namespace }
    end

    def file_extension
      '.md'
    end
  end
end
