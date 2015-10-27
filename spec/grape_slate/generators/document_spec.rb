require 'spec_helper'

describe GrapeSlate::Generators::Document do
  let(:routes) do
    SampleAPI.routes.select {|route| route.route_namespace == namespace}
  end

  subject(:document) { described_class.new(namespace, routes) }


  describe '#generate' do
    let(:namespace) { '/cases' }

    subject(:generate) { document.generate }

    it do
      is_expected.to eq(
        ["# Cases", "## Get a list of all cases", "```shell\ncurl /v1/cases --request GET --data '{\"limit_results\":100}' --header 'Content-Type: application/json' --verbose\n```", "This is useful if you need to display an index page of cases on\nyour application. It is also handy if you want to limit the results of a\nrequest to the first 100 returned values.\n\nWe can add multiline comments here!", "### HTTP Request\n`GET /v1/cases`", "### Query Parameters\nParameter | Type | Required | Description\n--------- | ---- | -------- | -----------\nlimit_results | Integer | `false` | Return this number of cases as a maximum", "## individual case", "```shell\ncurl /v1/cases/:id --request GET --data '{}' --header 'Content-Type: application/json' --verbose\n```", "### HTTP Request\n`GET /v1/cases/:id`", "### Query Parameters\nParameter | Type | Required | Description\n--------- | ---- | -------- | -----------\n", "## create a case", "```shell\ncurl /v1/cases --request POST --data '{\"name\":\"super case\",\"description\":\"the best case ever made\"}' --header 'Content-Type: application/json' --verbose\n```", "### HTTP Request\n`POST /v1/cases`", "### Request Parameters\nParameter | Type | Required | Description\n--------- | ---- | -------- | -----------\nname | String | `true` | the cases name\ndescription | String | `false` | the cases name", "## update a case", "```shell\ncurl /v1/cases/:id --request PUT --data '{}' --header 'Content-Type: application/json' --verbose\n```", "### HTTP Request\n`PUT /v1/cases/:id`", "### Request Parameters\nParameter | Type | Required | Description\n--------- | ---- | -------- | -----------\nname | String | `false` | the cases name\ndescription | String | `false` | the cases name"]
      )
    end
  end


  describe '#filename' do
    subject(:filename) { document.filename }

    context 'when namespace is at root level' do
      let(:namespace) { '/cases' }

      it { is_expected.to eq 'cases' }
    end

    context 'when namespace is nested' do
      let(:namespace) { '/cases/:case_id/studies' }

      it { is_expected.to eq 'studies' }
    end
  end
end
