require 'spec_helper'

describe YAPAAS do
  it 'has a version number' do
    expect(YAPAAS::VERSION).not_to be nil
  end

  describe 'helper methods' do
    subject { described_class }
    it { is_expected.to respond_to(:machines) }
    it { is_expected.to respond_to(:machine?) }
  end
end
