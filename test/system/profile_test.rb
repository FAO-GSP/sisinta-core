require 'application_system_test_case'

class ProfileTest < ApplicationSystemTestCase
  let(:owner) { create :authorized, :confirmed }
  let(:authorized) { create :authorized, :confirmed }
  let(:registered) { create :user, :confirmed }
  let(:profile) { create :profile, user: owner }

  describe 'show' do
    describe 'when it is geolocated' do
      it 'has required markup' do
        visit profile_path(create(:location, :geolocated).profile.to_param)

        page.must_have_selector '#map-tab'
      end
    end

    describe 'when it is not geolocated' do
      it 'does not show a map tab' do
        visit profile_path(create(:profile).to_param)

        page.wont_have_selector '#map-tab'
      end
    end
  end

  describe 'delete' do
    describe 'when logged in as owner' do
      before do
        login owner
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

    describe 'when logged in as authorized' do
      it 'does not show a button to delete the profile' do
        login authorized
        visit profile_path(profile.to_param)

        page.wont_have_link t('delete'), href: profile_path(profile.to_param)
      end
    end

    describe 'when not logged in' do
      it 'does not show a button to delete the profile' do
        visit profile_path(profile.to_param)

        page.wont_have_link t('delete'), href: profile_path(profile.to_param)
      end
    end
  end

  describe 'new' do
    describe 'when logged in as authorized or owner' do
      before { login owner }

      it 'can create profiles from show' do
        # Can be owner or not
        visit profile_path(profile)

        page.must_have_link I18n.t('new'), href: new_profile_path
      end

      it 'can create profiles from edit' do
        # Must be owner
        visit edit_profile_path(profile)

        page.must_have_link I18n.t('new'), href: new_profile_path
      end
    end

    describe 'when guest or logged in as registered' do
      it 'cannot create profiles' do
        # Guest
        visit profile_path(profile)

        page.wont_have_link I18n.t('new'), href: new_profile_path

        login registered
        visit profile_path(profile)

        page.wont_have_link I18n.t('new'), href: new_profile_path
      end
    end
  end

  describe 'edit' do
    describe 'when logged in as authorized' do
      before { login authorized }

      it 'cannot edit a foreign profile' do
        visit profile_path(profile)

        page.wont_have_link I18n.t('edit'), href: edit_profile_path(profile)
      end
    end

    describe 'when logged in as owner' do
      before { login owner }

      it 'can edit an owned profile' do
        visit profile_path(profile)

        page.must_have_link I18n.t('edit'), href: edit_profile_path(profile)
      end
    end

    describe 'when guest or logged in as registered' do
      it 'cannot edit profiles' do
        # Guest
        visit profile_path(profile)

        page.wont_have_link I18n.t('edit'), href: edit_profile_path(profile)

        login registered
        visit profile_path(profile)

        page.wont_have_link I18n.t('edit'), href: edit_profile_path(profile)
      end
    end
  end
end
