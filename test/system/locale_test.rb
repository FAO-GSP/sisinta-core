require 'application_system_test_case'

class LocaleTest < ApplicationSystemTestCase
  describe 'root_path' do
    it 'redirects to localized_root_path' do
      visit root_path

      current_path.must_equal localized_root_path
    end

    it 'defaults to spanish' do
      visit root_path

      page.must_have_content t('layouts.menu.languages.title', locale: :es)

      visit root_path(locale: nil)

      page.must_have_content t('layouts.menu.languages.title', locale: :es)
    end
  end

  describe 'selecting a locale' do
    it 'can select locale by url' do
      visit any_path(locale: :en)

      page.must_have_content t('layouts.menu.languages.title', locale: :en)
    end

    it 'can select locale by menu items' do
      visit any_path

      I18n.available_locales.each do |locale|
        page.wont_have_content ApplicationHelper.localized_locale_name(locale)
      end

      click_link t('layouts.menu.languages.title')

      I18n.available_locales.each do |locale|
        page.must_have_content ApplicationHelper.localized_locale_name(locale)
      end

      click_link ApplicationHelper.localized_locale_name(:en)

      page.must_have_content t('layouts.menu.languages.title', locale: :en)
    end
  end
end
