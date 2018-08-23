require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  subject { create :user }

  it 'can login' do
    visit new_user_session_path

    page.must_have_selector 'input[type=email]', count: 1
    page.must_have_selector 'input[type=password]', count: 1

    within 'form#new_user' do
      fill_in 'user_email', with: subject.email
      fill_in 'user_password', with: subject.password

      click_button I18n.t('devise.sessions.new.submit')
    end
  end
end
