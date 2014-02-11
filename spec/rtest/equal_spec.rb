require 'rtest/equal'
require 'constants'

describe RTest::Equal, "#match?" do
  subject { described_class.new(A_VALUE) }

  context "when both values match" do
    it { expect(subject.match?(A_VALUE)).to be_true }
  end

  context "when values do not match" do
    it { expect(subject.match?(ANOTHER_VALUE)).to be_false }
  end
end
