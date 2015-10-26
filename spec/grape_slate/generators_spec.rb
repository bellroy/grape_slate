require 'spec_helper'

describe GrapeSlate::Generators::Base do
  subject(:generator) { described_class.new}

  describe '#documentable_route_path' do
    let(:route) { Grape::Route.new }
    subject(:documentable_route_path) { generator.documentable_route_path(route)}

    before do      
      allow(GrapeSlate).to receive_message_chain(:configuration, :base_path).and_return('http://abc.com')
    end

    #TODO : improve stubbing so there's no need for route_path/route_version mocks ( should come from resource object)
    context "when api version not present" do
      before do
        allow_any_instance_of(Grape::Route).to receive(:route_path).and_return("/:version/cases/:id/studies(.:format)")
        allow_any_instance_of(Grape::Route).to receive(:route_version).and_return("v1")
      end

      it { is_expected.to eq "http://abc.com/v1/cases/:id/studies" }
    end

    context "when api version not present" do
      before do
        allow_any_instance_of(Grape::Route).to receive(:route_path).and_return("/cases/:id/studies(.:format)")
        allow_any_instance_of(Grape::Route).to receive(:route_version).and_return(nil)
      end

      it { is_expected.to eq "http://abc.com/cases/:id/studies" }
    end    
  end
end
