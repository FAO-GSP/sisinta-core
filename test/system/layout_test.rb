require 'application_system_test_case'

class LayoutTest < ApplicationSystemTestCase
  let(:user) { create :user, :confirmed }
  let(:admin) { create :admin, :confirmed }

  before { visit root_path }

  describe 'search' do
    it 'can be toggled' do
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

  describe 'admin panel' do
    it 'is visible on login' do
      page.wont_have_link href: admin_root_path

      login admin

      page.must_have_link href: admin_root_path
    end

    it 'is visible only for admins' do
      page.wont_have_link href: admin_root_path

      login user

      page.wont_have_link href: admin_root_path
    end
  end
end
