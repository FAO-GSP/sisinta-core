# VCR configuration for replaying HTTP responses

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr'
  c.hook_into :webmock
end
