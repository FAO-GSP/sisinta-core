require 'application_system_test_case'

class MapTest < ApplicationSystemTestCase
  test 'has required markup' do
    visit map_index_path

    assert_selector '#container-map'
    assert_selector '#map'
  end
end
