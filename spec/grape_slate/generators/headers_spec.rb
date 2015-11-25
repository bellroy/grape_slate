require 'spec_helper'

describe GrapeSlate::Generators::Headers do
  let(:routes) do
    SampleAPI.routes.select do |route|
      route.route_namespace == '/cases/:case_id/studies'
    end
  end

  subject(:parameters) { described_class.new(routes[3].route_headers) }

  describe '#generate' do
    subject(:generate) { parameters.generate }

    let(:response) do
<<-RESP
### Request Headers
Header | Required | Values | Description
------ | -------- | ------ | -----------
Content-Type | `true` | `["image/png", "application/zip"]` | Defines content media type
RESP
    end

    it { is_expected.to eq response.strip }
  end
end
