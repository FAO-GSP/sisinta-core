require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  subject { create :user, :confirmed }

  describe 'sessions' do
    it 'can login' do
      visit new_user_session_path

      page.must_have_selector 'input[type=email]', count: 1
      page.must_have_selector 'input[type=password]', count: 1

      within 'form#user' do
        fill_in 'user_email', with: subject.email
        fill_in 'user_password', with: subject.password

        click_button t('devise.sessions.new.sign_in')
      end

      page.must_have_content t('devise.sessions.signed_in')
    end

    it 'is redirected to localized_root after signin in or out' do
      visit any_path

      login subject

      current_path.must_equal localized_root_path

      visit any_path

      click_link t('devise.menu.session_link.sign_out')

      current_path.must_equal localized_root_path
    end
  end

  describe 'registrations' do
    subject { build :user }

    it 'can sign up but must confirm mail' do
      visit new_user_registration_path

      within 'form#user' do
        fill_in 'user_email', with: subject.email
        fill_in 'user_name', with: subject.name
        fill_in 'user_password', with: subject.password
        fill_in 'user_password_confirmation', with: subject.password

        click_button t('devise.registrations.new.sign_up')
      end

      login subject

      page.must_have_content t('devise.failure.unconfirmed')
      current_path.must_equal new_user_session_path
    end

    it 'is redirected to localized_root after sign up' do
      sign_up subject

      page.must_have_content t('devise.registrations.signed_up_but_unconfirmed')
      current_path.must_equal localized_root_path
    end
  end

  describe 'confirmations' do
    it 'is redirected to sign in after confirmed' do
      unconfirmed_user = create :user

      visit user_confirmation_path confirmation_token: unconfirmed_user.confirmation_token

      page.must_have_content t('devise.confirmations.confirmed')
      current_path.must_equal new_user_session_path

      login unconfirmed_user

      page.must_have_content t('devise.sessions.signed_in')
      current_path.must_equal localized_root_path
    end
  end
end
