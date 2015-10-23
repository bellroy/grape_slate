require 'spec_helper'

describe GrapeSlate::DocumentationGenerator do
  subject(:generator) { described_class.new(SampleAPI) }

  describe '#namespaces' do
    subject(:namespaces) { generator.namespaces }
    it { is_expected.to eq ["/cases", "/cases/:case_id/studies", "/admin"] }
  end
end
