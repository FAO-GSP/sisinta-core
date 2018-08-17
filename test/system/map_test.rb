require 'application_system_test_case'

class MapTest < ApplicationSystemTestCase
  test 'has map' do
    visit map_index_path

    assert page.has_css?('#container-map')
    assert page.has_css?('#map')
  end
end
