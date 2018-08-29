require 'application_system_test_case'

class LocaleTest < ApplicationSystemTestCase
  # Selects current locale based on :locale block variable
  before { I18n.locale = locale }
  # Returns current locale to default for the rest of the suite
  after { I18n.locale = I18n.default_locale }

  describe 'default' do
    let(:locale) { :es }

    it 'defaults to spanish' do
      visit root_path

      page.must_have_content I18n.t('layouts.menu.languages.title')

      visit root_path(locale: nil)

      page.must_have_content I18n.t('layouts.menu.languages.title')
    end
  end

  describe 'selecting a locale' do
    let(:locale) { :en }

    it 'can select locale by url' do
      visit root_path(locale: locale)

      page.must_have_content I18n.t('layouts.menu.languages.title')
    end
  end
end
