require 'find'

module RTest
  module FileGetter

    def self.files_from_args
      args.map do |file_path|
        Find.find(file_path) { |path| path if File.file?(path) }
      end.compact!
    end

    def self.args
      ARGV.drop(1)
    end
  end
end
