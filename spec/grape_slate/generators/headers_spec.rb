require 'spec_helper'

describe GrapeSlate::Generators::Headers do
  let(:route_headers) do
    SampleAPI.routes.select {|route| route.route_namespace == '/cases/:case_id/studies' }[3].route_headers
  end

  subject(:parameters) { described_class.new(route_headers) }

  describe '#generate' do
    subject(:generate) { parameters.generate }

    it { is_expected.to eq "### Request Headers\nHeader | Required / Values | Description\n------ | ----------------- | -----------\nContentType | `true` [\"image/png\", \"application/zip\"] | Defines content media type" }
  end
end
