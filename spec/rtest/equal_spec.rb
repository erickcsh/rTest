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

describe RTest::Equal, "#failure_message_for_to" do
  subject { described_class.new(A_VALUE) }

  before { subject.match?(ANOTHER_VALUE) }

  it "returns not equal message" do
    expect(subject.failure_message_for_to).to eq(FAILURE_MESSAGE_FOR_TO)
  end
end

describe RTest::Equal, "#failure_message_for_not_to" do
  subject { described_class.new(A_VALUE) }

  before { subject.match?(A_VALUE) }

  it "returns equal message" do
    expect(subject.failure_message_for_not_to).to eq(FAILURE_MESSAGE_FOR_NOT_TO)
  end
end

describe RTest::Equal, "#success_message_for_to" do
  subject { described_class.new(A_VALUE) }

  before { subject.match?(A_VALUE) }

  it "returns equal message" do
    expect(subject.success_message_for_to).to eq(SUCCESS_MESSAGE_FOR_TO)
  end
end

describe RTest::Equal, "#success_message_for_not_to" do
  subject { described_class.new(A_VALUE) }

  before { subject.match?(ANOTHER_VALUE) }

  it "returns not equal message" do
    expect(subject.success_message_for_not_to).to eq(SUCCESS_MESSAGE_FOR_NOT_TO)
  end
end
