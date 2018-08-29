require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Model initialization helpers
  include FactoryBot::Syntax::Methods

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  # Logs in a user using the web interface
  def login(user)
    visit new_user_session_path

    within 'form#new_user' do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      click_button I18n.t('devise.sessions.new.submit')
    end
  end
end
