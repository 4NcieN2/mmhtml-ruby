require 'rubygems'
require 'bundler/setup'
require 'rspec/its'

Bundler.setup

require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

require 'mMHTML'

RSpec.configure do |config|
	# => Configurations
end