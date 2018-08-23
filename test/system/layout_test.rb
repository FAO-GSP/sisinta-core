require 'application_system_test_case'

class LayoutTest < ApplicationSystemTestCase
  it 'can toggle search' do
    visit map_index_path

    page.must_have_content I18n.t('map.index.title')
    page.must_have_selector 'form.global-search', visible: :hidden

    click_link I18n.t('layouts.navbar.search')

    page.wont_have_content I18n.t('map.index.title')
    page.must_have_selector 'form.global-search', visible: :visible

    click_link I18n.t('layouts.navbar.search')

    page.must_have_content I18n.t('map.index.title')
    page.must_have_selector 'form.global-search', visible: :hidden
  end
end
