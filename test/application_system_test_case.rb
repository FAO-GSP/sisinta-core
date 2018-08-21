require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Model initialization helpers
  include FactoryBot::Syntax::Methods

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
