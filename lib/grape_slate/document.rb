module GrapeSlate
  class Document
    def initialize(api_class)
      self.api_class = api_class
    end

    def generate

      namespaces.map do |namespace|
        namespace_array = []
        namespace_array << title_for(namespace)

        routes_for(namespace).map do |route|
          namespace_array << "## #{route.route_description}"
          namespace_array << "#{route.route_detail}"
          namespace_array << "### HTTP Request"
          namespace_array << "`#{route.route_method} #{route.route_path}`"
          if route.route_params.present?
            if ['POST', 'PUT', 'PATCH'].include? route.route_method
              namespace_array << "### Request Parameters"
              namespace_array << "Parameter | Type | Required | Description"
              namespace_array << "--------- | ---- | -------- | -----------"
              namespace_array << route.route_params.map {|k,v| [k, v[:type].capitalize, "`#{v[:required]}`", v[:desc]].join(' | ') unless v.is_a?(String) }.compact
            else
              namespace_array << "### Query Parameters"
              namespace_array << "Parameter | Type | Required | Description"
              namespace_array << "--------- | ---- | -------- | -----------"
              namespace_array << route.route_params.map {|k,v| [k, v[:type].capitalize, "`#{v[:required]}`", v[:desc]].join(' | ') unless v.is_a?(String) }.compact
            end
          end
        end

        namespace_array

      end.flatten
    end

    def namespaces
      api_class.routes.map(&:route_namespace).uniq
    end

    def routes_for(namespace)
      api_class.routes.select {|route| route.route_namespace == namespace }
    end

    def title_for(namespace)
      "# #{namespace.split('/').last.capitalize}"
    end

    private

    attr_accessor :api_class
  end
end
