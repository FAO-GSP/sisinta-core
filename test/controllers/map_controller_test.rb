require 'test_helper'

class MapControllerTest < ActionDispatch::IntegrationTest
  test 'it gets index' do
    get map_index_url

    assert_response :success
  end
end
