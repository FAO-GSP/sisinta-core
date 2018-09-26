require 'application_system_test_case'

class ProfileTest < ApplicationSystemTestCase
  describe 'when it is geolocated' do
    let(:profile) { create(:location, :geolocated).profile }

    it 'has required markup' do
      visit profile_path(profile.to_param)

      page.must_have_selector '#map-tab'
    end
  end

  describe 'when it is not geolocated' do
    let(:profile) { create :profile }

    it 'does not show a map tab' do
      visit profile_path(profile.to_param)

      page.wont_have_selector '#map-tab'
    end
  end
end
