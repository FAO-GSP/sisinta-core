require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  let(:profile) { create :profile }

  describe '#index' do
    it 'gets a response' do
      get profiles_path

      must_respond_with :success
    end

    it 'gets a geojson response' do
      get profiles_path(format: :geojson)

      must_respond_with :success
    end
  end

  describe '#show' do
    it 'gets a response' do
      get profile_path(profile.to_param)

      must_respond_with :success
    end

    it 'gets a geojson response' do
      get profile_path(profile.to_param, format: :geojson)

      must_respond_with :success
    end
  end

  describe '#destroy' do
    let(:user) { create :authorized, :confirmed }
    let(:profile) { create :profile, user: user }

    describe 'when owner is logged in' do
      before { sign_in user }

      it 'destroys a profile' do
        profile.must_be :persisted?

        lambda do
          delete profile_path(profile.to_param)
        end.must_change 'Profile.count', -1
      end

      it 'gets a response' do
        delete profile_path(profile.to_param)

        must_redirect_to profiles_path
      end
    end

    describe 'when not authorized' do
      it 'does not destroy the profile' do
        profile.must_be :persisted?

        lambda do
          delete profile_path(profile.to_param)
        end.wont_change 'Profile.count'
      end

      it 'redirects to root' do
        delete profile_path(profile.to_param)

        must_redirect_to localized_root_path
      end
    end
  end

  describe 'routes' do
    it 'understands filtered_profiles' do
      value({
        controller: 'profiles', action: 'index', locale: 'es', filter: 'owned'
      }).must_route_for '/es/profiles/owned'
    end

    it 'understands index' do
      value({
        controller: 'profiles', action: 'index', locale: 'es'
      }).must_route_for '/es/profiles'
    end
  end
end
