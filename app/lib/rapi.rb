# Wrapper for the companion R API

class Rapi
  include HTTParty

  base_uri Rails.configuration.x['rapi']['base_path']
end
