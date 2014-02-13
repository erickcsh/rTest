module RTest
  module MainTest

    @@tests = []

    def the(message, optional_message = '', &block)
      @@tests << RTest::NestedTest.new(message, optional_message, &block)
    end

    def run_tests
      @@tests.each { |test| test.run }
    end

    def run
      files = RTest::FileGetter.files_from_args
      files.each { |file| process_file(file) }
      run_tests
    end

    def tests
      @@tests
    end

    private
    def process_file(file)
      add_dir_to_load_path(file)
      eval(File.read(file)) 
    end

    def file_full_path(file)
      File.dirname(File.expand_path(file))
    end

    def add_dir_to_load_path(file)
      path = file_full_path(file)
      $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
    end
  end
end
