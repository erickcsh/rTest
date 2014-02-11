require 'rtest'
require 'constants'

describe RTest::NestedTest, "#have_to" do
  let(:test) { double(:test).as_null_object }

  subject { described_class.new(A_CLASS) { have_to } }

  before { allow(RTest::Test).to receive(:new) { test } }

  its(:tests) { should == [test] }
end

describe RTest::NestedTest, "#run" do
  let(:test) { double(:test).as_null_object }

  subject { described_class.new(A_CLASS, A_MESSAGE) { have_to } }

  before do
    allow(STDOUT).to receive(:puts)
    allow(RTest::Test).to receive(:new) { test }
  end

  after { subject.run }

  context "when there is a second message" do
    it "displays optional message" do
      expect(STDOUT).to receive(:puts).once.with("#{A_CLASS}#{A_MESSAGE}")
    end
  end

  context "when there is no second message" do
    subject { described_class.new(A_CLASS) }

    it "does not display optional message" do
      expect(STDOUT).to receive(:puts).with("#{A_CLASS}")
    end
  end

  it "runs the tests" do
    expect(test).to receive(:run)
  end
end
