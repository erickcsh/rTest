require 'find'

module RTest
  module FileGetter

    def self.files_from_args
      files = []
      args.each do |file_path|
        Find.find(file_path) { |path| files << path if File.file?(path) }
      end
      files
    end

    def self.args
      ARGV
    end
  end
end
