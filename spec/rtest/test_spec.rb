require 'rtest'
require 'constants'

describe RTest::Test, "#expect" do
  let(:expectation) { double(:expectation).as_null_object }

  subject { described_class.new(A_MESSAGE) { expect(A_OBJECT) } }

  before { allow(RTest::Expect).to receive(:new){ expectation } }

  its(:expectations) { should == [expectation] }
end

describe RTest::Test, "#equal" do
  let(:equal) { double(:equal).as_null_object }

  subject { described_class.new(A_MESSAGE) }

  before { allow(RTest::Equal).to receive(:new){ equal } }

  it "creates an equal matcher object" do
    expect(subject.equal(A_OBJECT)).to eq(equal)
  end
end

describe RTest::Test, "#run" do
  let(:passing_expectation) { double(:passing_expectation).as_null_object }
  let(:not_passing_expectation) { double(:not_passing_expectation).as_null_object }
  let(:console) { double(:console).as_null_object }

  subject { described_class.new(A_MESSAGE) { expect(A_OBJECT) } }

  before do
    allow(RTest::Expect).to receive(:new){ passing_expectation } 
    allow(passing_expectation).to receive(:pass?) { true }
    allow(passing_expectation).to receive(:passing_message) { PASSING_MESSAGE }
    allow(not_passing_expectation).to receive(:pass?) { false }
    allow(not_passing_expectation).to receive(:failure_message) { FAILURE_MESSAGE }
    allow(RTest::Console).to receive(:instance) { console }
  end

  after { subject.run }

  it "runs the expectations" do
    expect(passing_expectation).to receive(:pass?)
  end

  context "when expectations pass" do
    context "when a message is provided" do
      it "displays message passing" do
        expect(console).to receive(:display_leveled_message).with(1, A_MESSAGE, :green)
      end
    end

    context "when no message is provided" do
      subject { described_class.new { expect(A_OBJECT) } }

      it "displays expectation provided message" do
        expect(console).to receive(:display_leveled_message).with(1, PASSING_MESSAGE, :green)
      end
    end
  end

  context "when there are no expectations" do
    subject { described_class.new(A_MESSAGE) }

    it "does not display anything" do
      expect(console).not_to receive(:display_leveled_message)
    end
  end

  context "when expectations does not pass" do
    before { allow(RTest::Expect).to receive(:new){ not_passing_expectation } }

    it "raises an error" do
      expect { receive(:rescue).with(RTest::TestFailureError) }
    end

    it "displays error message" do
      expect(console).to receive(:display_leveled_message).once.with(1, A_MESSAGE, :red)
    end

    it "displays failure message" do
      expect(console).to receive(:display_leveled_message).once.with(2, not_passing_expectation.failure_message, :red)
    end
  end
end
