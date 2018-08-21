require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get profiles_path

    assert_response :success
  end

  test 'should get show' do
    get profile_path create(:profile).to_param

    assert_response :success
  end
end
