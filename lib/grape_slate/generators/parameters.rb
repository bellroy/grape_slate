module GrapeSlate
  module Generators
    class Parameters
      def initialize(params, method)
        self.params = params
        self.method = method
      end

      def generate
        array = []

        if params.present? && !params.values.all?(&:blank?)
          if ['POST', 'PUT', 'PATCH'].include? method
            array << "### Request Parameters"
          else
            array << "### Query Parameters"
          end
          array << "Parameter | Type | Required / Values | Description"
          array << "--------- | ---- | ----------------- | -----------"
          array << params.map {|k,v| [k, v[:type].capitalize, "`#{v[:required]}` #{v[:values]}", v[:desc]].join(' | ') unless v.is_a?(String) }.compact
        end

        return array.join("\n")
      end

      private

      attr_accessor :params, :method
    end
  end
end
