$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'paitin_hangman'

require 'simplecov'
SimpleCov.start

require 'codeclimate-test-reporter'
CodeClimate::TestReporter::Formatter
