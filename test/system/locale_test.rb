require 'application_system_test_case'

class LocaleTest < ApplicationSystemTestCase
  describe 'default' do
    it 'defaults to spanish' do
      visit root_path

      page.must_have_content I18n.t('layouts.menu.languages.title', locale: :es)

      visit root_path(locale: nil)

      page.must_have_content I18n.t('layouts.menu.languages.title', locale: :es)
    end
  end

  describe 'selecting a locale' do
    # Access to `localized_locale_name` helper
    include ApplicationHelper

    it 'can select locale by url' do
      visit root_path(locale: :en)

      page.must_have_content I18n.t('layouts.menu.languages.title', locale: :en)
    end

    it 'can select locale by menu items' do
      visit root_path

      I18n.available_locales.each do |locale|
        page.wont_have_content locale
        page.wont_have_content localized_locale_name(locale)
      end

      click_link I18n.t('layouts.menu.languages.title')

      I18n.available_locales.each do |locale|
        page.must_have_content locale
        page.must_have_content localized_locale_name(locale)
      end

      click_link localized_locale_name(:en)

      page.must_have_content I18n.t('layouts.menu.languages.title', locale: :en)
    end
  end
end
