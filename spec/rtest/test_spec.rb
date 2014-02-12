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

  subject { described_class.new(A_MESSAGE) { expect(A_OBJECT) } }

  before do
    allow(RTest::Expect).to receive(:new){ passing_expectation } 
    allow(passing_expectation).to receive(:pass?) { true }
    allow(passing_expectation).to receive(:passing_message) { PASSING_MESSAGE }
    allow(not_passing_expectation).to receive(:pass?) { false }
    allow(not_passing_expectation).to receive(:failure_message) { FAILURE_MESSAGE }
    allow(STDOUT).to receive(:puts)
  end

  after { subject.run }

  it "runs the expectations" do
    expect(passing_expectation).to receive(:pass?)
  end

  context "when expectations pass" do
    context "when a message is provided" do
      it "displays message passing" do
        expect(STDOUT).to receive(:puts).with("\t#{A_MESSAGE}")
      end
    end

    context "when no message is provided" do
      subject { described_class.new { expect(A_OBJECT) } }

      it "displays expectation provided message" do
        expect(STDOUT).to receive(:puts).with("\t#{PASSING_MESSAGE}")
      end
    end
  end

  context "when there are no expectations" do
    subject { described_class.new(A_MESSAGE) }

    it "does not display anything" do
      expect(STDOUT).not_to receive(:puts)
    end
  end

  context "when expectations does not pass" do
    before { allow(RTest::Expect).to receive(:new){ not_passing_expectation } }

    it "raises an error" do
      expect { receive(:rescue).with(RTest::TestFailureError) }
    end

    it "displays error message" do
      expect(STDOUT).to receive(:puts).once.with("\t#{A_MESSAGE}")
    end

    it "displays failure message" do
      expect(STDOUT).to receive(:puts).once.with("\t\t#{not_passing_expectation.failure_message}")
    end
  end
end
