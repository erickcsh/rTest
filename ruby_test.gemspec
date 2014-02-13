lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require File.expand_path("../lib/rtest/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'ruby_test'
  s.version = RTest::VERSION
  s.date '2014-02-13'
  s.summary = 'A simple gem to test equality in Ruby'
  s.description = 'RubyTest allows you to create simple nested examples in order to test classes you create, allows you to compare equality'
  s.authors = ['Erick Castillo']
  s.email = 'ecastillo@pernix-solutions.com'
  s.files = Dir.glob("{bin, lib}/**/*") + %w(README.md LICENSE)
  s.test_files = Dir['spec/*']
  s.executables << 'rtest'
  s.require_path = 'lib'
  s.homepage = 'https://github.com/erickcsh/rTest'
  s.license = 'MIT'
end
