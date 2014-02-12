require 'rtest/file_getter'

describe RTest::FileGetter, ".files_from_args" do
  let(:args) { ['file1', 'dir1', 'file2'] }

  before do
    allow(described_class).to receive(:args) { args } 
    allow(File).to receive(:file?).and_return(true, false, true)
    allow(Find).to receive(:find) { |path| path if File.file?(path) }
  end

  it "add files to the list" do
    expect(described_class.files_from_args).to eq(['file1', 'file2'])
  end
end
