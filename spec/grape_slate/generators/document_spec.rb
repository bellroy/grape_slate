require 'spec_helper'

describe GrapeSlate::Generators::Document do
  let(:routes) do
    SampleAPI.routes.select {|route| route.route_namespace == namespace}
  end

  subject(:document) { described_class.new(namespace, routes) }


  describe '#generate' do
    let(:namespace) { '/cases' }

    subject(:generate) { document.generate }

    it { is_expected.to eq '' }
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
