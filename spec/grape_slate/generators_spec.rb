require 'spec_helper'

describe GrapeSlate::Generators::Base do
  subject(:generator) { described_class.new }

  describe '#documentable_route_path' do
    let(:route) { Grape::Path.new(nil, nil, nil) }
    let(:base_path) { 'http://example.org' }
    subject(:documentable_route_path) { generator.documentable_route_path(route)}

    before do
      allow(GrapeSlate).to receive_message_chain(:configuration, :base_path).and_return(base_path)
    end

    #TODO : improve stubbing so there's no need for path/version mocks ( should come from resource object)
    context "when api version not present" do
      before do
        expect(route).to receive(:path).and_return("/:version/cases/:id/studies(.:format)")
        expect(route).to receive(:version).and_return("v1")
      end

      it { is_expected.to eq "#{base_path}/v1/cases/:id/studies" }
    end

    context "when api version not present" do
      before do
        expect(route).to receive(:path).and_return("/cases/:id/studies(.:format)")
        expect(route).to receive(:version).and_return(nil)
      end

      it { is_expected.to eq "#{base_path}/cases/:id/studies" }
    end
  end
end
