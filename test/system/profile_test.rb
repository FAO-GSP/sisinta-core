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

  describe 'destroy' do
    let(:user) { create :authorized, :confirmed }
    let(:profile) { create :profile, user: user }

    describe 'when logged in as owner' do
      before do
        login user
        visit profile_path(profile.to_param)
      end

      it 'can delete the profile' do
        page.must_have_link t('delete'), href: profile_path(profile.to_param)

        accept_confirm do
          click_link t('delete')
        end

        current_path.must_equal profiles_path
        page.must_have_content t('profiles.destroy.success')
      end
    end

    describe 'when not logged in as owner' do
      it 'does not show a button to delete the profile' do
        visit profile_path(profile.to_param)

        page.wont_have_link t('delete'), href: profile_path(profile.to_param)
      end
    end
  end
end
