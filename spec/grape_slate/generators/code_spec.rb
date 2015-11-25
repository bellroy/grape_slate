require 'spec_helper'

describe GrapeSlate::Generators::Code do
  let(:routes) do
    SampleAPI.routes.select {|route| route.route_namespace == '/cases'}
  end

  subject(:code) { described_class.new(route) }

  describe '#generate' do

    subject(:generate) { code.generate }

    context 'when route_setting[:example_response] exists' do
      let(:route) { routes[2] }

      it { is_expected.to eq "```shell\n curl /v1/cases --request POST --data '{\"name\":\"super case\",\"description\":\"the best case ever made\"}' --header 'Content-Type: application/json' --verbose\n ```\n\n> Example Response\n\n```json\n{\n  \"id\": 8731,\n  \"created_at\": \"Fri, 30 Oct 2015 09:52:21 +1100\",\n  \"description\": \"Your description here\",\n  \"name\": \"Case name\",\n  \"updated_at\": \"Fri, 30 Oct 2015 09:52:21 +1100\"\n}\n```" }
    end

    context 'with custom route headers' do
      let(:route) do
        SampleAPI.routes.select do |route|
          route.route_namespace == '/cases/:case_id/studies'
        end[3]
      end

      it { is_expected.to eq "```shell\n curl /v1/cases/:case_id/studies/:id/images --request POST --data '{}' --header 'Content-Type: image/png' --verbose\n ```\n\n" }
    end
  end
end
