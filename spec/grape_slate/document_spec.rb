require 'spec_helper'

describe GrapeSlate::Document do
  subject(:document) { GrapeSlate::Document.new(SampleAPI) }

  describe '#generate' do
    subject(:generate) { document.generate }

    it { is_expected.to eq '' }
  end

  describe '#namespaces' do
    subject(:namespaces) { document.namespaces }

    it { is_expected.to eq ["/cases", "/cases/:case_id/studies", "/admin"] }
  end

  describe '#routes_for' do
    subject(:routes_for) { document.routes_for('/cases') }

    specify { expect(routes_for.count).to eq 4 }
  end

  describe '#title_for' do
    subject(:title_for) { document.title_for(namespace) }

    context 'when namespace is at root level' do
      let(:namespace) { '/cases' }
      it { is_expected.to eq '# Cases' }
    end

    context 'when namespace is nested' do
      let(:namespace) { '/cases/:case_id/studies' }
      it { is_expected.to eq '# Studies' }
    end
  end
end
