# Trigger a request on a url warming any associated cache.

class WarmCacheJob < ApplicationJob
  def perform(url)
    session = ActionDispatch::Integration::Session.new(Rails.application)

    session.get url
  end
end
