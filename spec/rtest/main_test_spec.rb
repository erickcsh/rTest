require 'rtest'
require 'constants'

class TestMainTest
  include RTest::MainTest
end

describe TestMainTest, "#describe" do
  let(:test) { double(:test).as_null_object }

  subject { described_class.new }

  before do
    allow(RTest::NestedTest).to receive(:new) { test }
    subject.the(A_MESSAGE)
  end

  its(:tests) { should == [test] }
end

describe TestMainTest, "#run_tests" do
  let(:test) { double(:test).as_null_object }

  subject { described_class.new }

  before do
    allow(RTest::NestedTest).to receive(:new) { test }
    subject.the(A_MESSAGE)
  end

  after { subject.run_tests }

  it "runs every test" do
    expect(test).to receive(:run)
  end
end

describe TestMainTest, "#run" do
  let(:files) { FILES }

  subject { described_class.new }

  before do
    allow(RTest::FileGetter).to receive(:files_from_args) { files }
    allow(File).to receive(:expand_path)
    allow(File).to receive(:dirname) { ABSOLUTE_PATH }
    allow(File).to receive(:read) { |file| file }
    allow(subject).to receive(:eval)
  end

  after { subject.run }

  it "evals the files content" do
    expect(subject).to receive(:eval).once.with(FILES[0])
    expect(subject).to receive(:eval).once.with(FILES[1])
  end

  it "adds the absolute path of every file to the load path" do
    expect($LOAD_PATH).to include(ABSOLUTE_PATH)
  end
end
