require 'rtest'
require 'constants'

describe RTest::Expect, "#to" do
  let(:matcher) { double(:matcher, match?: true).as_null_object }

  subject { described_class.new(A_VALUE) }

  before do
    allow(matcher).to receive(:success_message_for_to) { SUCCESS_MESSAGE_FOR_TO }
    allow(matcher).to receive(:failure_message_for_to) { FAILURE_MESSAGE_FOR_TO }
    subject.to(matcher) 
  end

  context "when expectations match" do
    its(:pass?) { should be_true }
    its(:failure_message) { should be_nil }
    its(:passing_message) { should == SUCCESS_MESSAGE_FOR_TO }
  end

  context "when expectations do not match" do
    let(:matcher) { double(:matcher, match?: false, failure_message_for_to: FAILURE_MESSAGE).as_null_object }

    its(:pass?) { should be_false }
    its(:failure_message) { should == FAILURE_MESSAGE_FOR_TO }
    its(:passing_message) { should be_nil }
  end
end

describe RTest::Expect, "#not_to" do
  let(:matcher) { double(:matcher, match?: true).as_null_object }

  subject { described_class.new(A_VALUE) }

  before do
    allow(matcher).to receive(:success_message_for_not_to) { SUCCESS_MESSAGE_FOR_NOT_TO }
    allow(matcher).to receive(:failure_message_for_not_to) { FAILURE_MESSAGE_FOR_NOT_TO }
    subject.not_to(matcher) 
  end

  context "when expectations match" do
    its(:pass?) { should be_false }
    its(:failure_message) { should == FAILURE_MESSAGE_FOR_NOT_TO }
    its(:passing_message) { should be_nil }
  end

  context "when expectations do not match" do
    let(:matcher) { double(:matcher, match?: false).as_null_object }

    its(:pass?) { should be_true }
    its(:failure_message) { should be_nil }
    its(:passing_message) { should == SUCCESS_MESSAGE_FOR_NOT_TO }
  end
end
