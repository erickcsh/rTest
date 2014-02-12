require 'rtest'
require 'constants'

describe RTest::NestedTest, "#has_to" do
  let(:test) { double(:test).as_null_object }

  subject { described_class.new(A_CLASS) { has_to } }

  before { allow(RTest::Test).to receive(:new) { test } }

  its(:tests) { should == [test] }
end

describe RTest::NestedTest, "#run" do
  let(:test) { double(:test).as_null_object }
  let(:console) { double(:console).as_null_object }

  subject { described_class.new(A_CLASS, A_MESSAGE) { has_to } }

  before do
    allow(RTest::Console).to receive(:instance) { console }
    allow(RTest::Test).to receive(:new) { test }
  end

  after { subject.run }

  context "when there is a second message" do
    it "displays optional message" do
      expect(console).to receive(:display_leveled_message).with(0, "#{A_CLASS}#{A_MESSAGE}")
    end
  end

  context "when there is no second message" do
    subject { described_class.new(A_CLASS) }

    it "does not display optional message" do
      expect(console).to receive(:display_leveled_message).with(0, "#{A_CLASS}")
    end
  end

  it "runs the tests" do
    expect(test).to receive(:run)
  end
end
