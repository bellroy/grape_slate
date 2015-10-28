require 'spec_helper'

describe GrapeSlate::Generators::Parameters do
  let(:route_params) do
    SampleAPI.routes.select {|route| route.route_namespace == '/cases/:case_id/studies' }[1].route_params
  end

  let(:route_method) { 'POST' }

  subject(:parameters) { described_class.new(route_params, route_method) }

  describe '#generate' do
    subject(:generate) { parameters.generate }

    it { is_expected.to eq "### Request Parameters\nParameter | Type | Required / Values | Description\n--------- | ---- | ----------------- | -----------\nname | String | `true`  | the cases name\ncategory | String | `false` [\"Valid\", \"Funny\", \"Interesting\"] | the category for the case" }
  end
end
