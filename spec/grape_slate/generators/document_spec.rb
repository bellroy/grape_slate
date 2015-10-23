require 'spec_helper'

describe GrapeSlate::Generators::Document do
  let(:namespace) { '/cases' }
  let(:routes) do
    SampleAPI.routes.select {|route| route.route_namespace == namespace}
  end

  subject(:document) { described_class.new(namespace, routes) }

  describe '#generate' do
    subject(:generate) { document.generate }
    it { is_expected.to eq '' }
  end

  describe '#title' do
    subject(:title) { document.title }

    context 'when namespace is at root level' do
      let(:namespace) { '/cases' }
      it { is_expected.to eq 'Cases' }
    end

    context 'when namespace is nested' do
      let(:namespace) { '/cases/:case_id/studies' }
      it { is_expected.to eq 'Studies' }
    end
  end
end
