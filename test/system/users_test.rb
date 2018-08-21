require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'can login' do
    user = create :user
    visit new_user_session_path

    assert_selector 'input[type=email]', count: 1
    assert_selector 'input[type=password]', count: 1

    within 'form#new_user' do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      click_button I18n.t('devise.sessions.new.submit')
    end
  end
end
