require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  describe ApplicationHelper do
    describe '#localized_locale_name' do
      it "returns a locale name on it's own language" do
        localized_locale_name(:es).must_equal 'Español'
        localized_locale_name(:en).must_equal 'English'
      end
    end

    describe '#link_to_locale' do
      it 'returns a link for locale switching' do
        stub :url_for, '/es' do
          link_to_locale('es').must_include 'Español (es)'
          link_to_locale('es').must_include '/es'
        end

        stub :url_for, '/en' do
          link_to_locale('en').must_include "English (en)"
          link_to_locale('en').must_include '/en'
        end
      end
    end

    describe '#country_from_code' do
      it 'returns a country object' do
        country_from_code('ARG').must_be_instance_of ISO3166::Country
      end
    end
  end
end
