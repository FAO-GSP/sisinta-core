require 'application_system_test_case'

class LayoutTest < ApplicationSystemTestCase
  test 'can toggle search' do
    visit map_index_path

    assert_content I18n.t('map.index.title')
    assert_selector 'form.global-search', visible: :hidden

    click_link I18n.t('layouts.navbar.search')

    refute_content I18n.t('map.index.title')
    assert_selector 'form.global-search', visible: :visible

    click_link I18n.t('layouts.navbar.search')

    assert_content I18n.t('map.index.title')
    assert_selector 'form.global-search', visible: :hidden
  end
end
