lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require File.expand_path("../lib/rtest/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'ruby_test'
  s.version = RTest::VERSION
  s.date = '2014-01-31'
  s.summary = 'Allows testing for equality in ruby'
  s.description = 'Testing suite for Ruby, allows to test for equality with nested examples'
  s.authors = ['Erick Castillo']
  s.email = 'ecastillo@pernix-solutions.com'
  s.files = Dir.glob("{bin,lib}/**/*") + %w(README.md LICENSE)
  s.test_files = Dir['spec/*']
  s.executables << 'rtest'
  s.homepage = 'https://github.com/erickcsh/rTest'
  s.license = 'MIT'
end
