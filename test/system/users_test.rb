require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'can login' do
    visit new_user_session_path

    assert_selector 'input[type=email]', count: 1
    assert_selector 'input[type=password]', count: 1
  end
end
