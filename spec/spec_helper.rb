require "rubygems"
require "bundler/setup"
Bundler.setup

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "mMHTML"

RSpec.configure do |config|
	# # => 
end