require 'application_system_test_case'

class MapTest < ApplicationSystemTestCase
  it 'has required markup' do
    visit map_index_path

    page.must_have_selector '#map-container.d-flex'
    page.must_have_selector '#map'
  end
end
