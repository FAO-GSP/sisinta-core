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

      click_button I18n.t('devise.sessions.new.sign_in')
    end
  end

  def sign_up(user)
    visit new_user_registration_path

    within 'form#new_user' do
      fill_in 'user_email', with: subject.email
      fill_in 'user_name', with: subject.name
      fill_in 'user_password', with: subject.password
      fill_in 'user_password_confirmation', with: subject.password

      click_button I18n.t('devise.registrations.new.sign_up')
    end
  end
end
