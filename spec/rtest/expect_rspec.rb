require 'rtest'
require 'constants'

describe RTest::Expect, "#to" do
  let(:matcher) { double(:matcher, match?: true).as_null_object }

  subject { described_class.new(A_VALUE) }

  before { subject.to(matcher) }

  context "when expectations match" do
    its(:pass?) { should be_true }
    its(:failure_message) { should be_nil }
  end

  context "when expectations do not match" do
    let(:matcher) { double(:matcher, match?: false, failure_message_for_to: FAILURE_MESSAGE).as_null_object }

    its(:pass?) { should be_false }
    its(:failure_message) { should == FAILURE_MESSAGE }
  end
end

describe RTest::Expect, "#not_to" do
  let(:matcher) { double(:matcher, match?: true, failure_message_for_not_to: FAILURE_MESSAGE).as_null_object }

  subject { described_class.new(A_VALUE) }

  before { subject.not_to(matcher) }

  context "when expectations match" do
    its(:pass?) { should be_false }
    its(:failure_message) { should == FAILURE_MESSAGE }
  end

  context "when expectations do not match" do
    let(:matcher) { double(:matcher, match?: false).as_null_object }

    its(:pass?) { should be_true }
    its(:failure_message) { should be_nil }
  end
end
