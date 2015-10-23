require 'spec_helper'

describe GrapeSlate::DocumentationGenerator do
  subject(:generator) { described_class.new(SampleAPI) }

  describe '#run!' do
    subject(:run) { generator.run! }

    it { is_expected.to eq '' }
  end

  describe '#namespaces' do
    subject(:namespaces) { generator.namespaces }
    it { is_expected.to eq ["/cases", "/cases/:case_id/studies", "/admin"] }
  end
end
