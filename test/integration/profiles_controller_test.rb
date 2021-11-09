require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  let(:profile) { create :profile }

  describe 'as guest' do
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
      let(:non_public) { create :profile, public: false }

      it 'gets a response' do
        get profile_path(profile.to_param)

        must_respond_with :success
      end

      it 'gets a geojson response' do
        get profile_path(profile.to_param, format: :geojson)

        must_respond_with :success
      end

      it 'redirects to root if profile is not public' do
        get profile_path(non_public.to_param)

        must_redirect_to :localized_root
      end

      it 'returns forbidden status if not public' do
        get profile_path(non_public.to_param, format: :geojson)

        must_respond_with :forbidden
      end
    end

    describe '#destroy' do
      it 'redirects to root' do
        delete profile_path(profile.to_param)

        must_redirect_to :localized_root
      end

      it 'does not destroy the profile' do
        profile.must_be :persisted?

        lambda do
          delete profile_path(profile.to_param)
        end.wont_change 'Profile.count'
      end
    end

    describe '#edit' do
      it 'redirects to root' do
        get edit_profile_path(profile.to_param)

        must_redirect_to :localized_root
      end
    end

    describe '#update' do
      it 'redirects to root' do
        patch profile_path(profile.to_param), params: { profile: {} }

        must_redirect_to :localized_root
      end

      it 'does not update the profile' do
        patch profile_path(profile.to_param), params: {
          profile: { identifier: 'forbidden' }
        }

        profile.reload.identifier.wont_equal 'forbidden'
      end
    end
  end

  describe 'signed in' do
    let(:user) { create :authorized, :confirmed }
    let(:profile) { create :profile, user: user }

    before { sign_in user }

    describe '#destroy' do
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

    describe '#edit' do
      it 'gets a response' do
        get edit_profile_path(profile.to_param)

        must_respond_with :success
      end
    end

    describe '#update' do
      let(:profile) { create :profile, :complete, user: user, country_code: 'ARG' }
      let(:new_profile_type) { create :profile_type }
      let(:new_license) { create :license }

      it 'updates a profile' do
        # Some customizations have only 1 valid country code.
        sample_country_code = Rails.configuration.engine.default_country_codes.sample

        patch profile_path(profile.to_param), params: {
          profile: {
            identifier: 'new identifier',
            type_id: new_profile_type.to_param.to_s,
            date: '15/10/1979',
            country_code: sample_country_code,
            order: 'new order',
            source: 'new source',
            contact: 'new contact',
            license_id: new_license.to_param.to_s,
            public: '1'
          }
        }

        profile.reload
        profile.identifier.must_equal 'new identifier'
        profile.type.must_equal new_profile_type
        profile.date.must_equal Date.new(1979, 10, 15)
        profile.country_code.must_equal sample_country_code
        profile.order.must_equal 'new order'
        profile.source.must_equal 'new source'
        profile.contact.must_equal 'new contact'
        profile.license.must_equal new_license
        profile.public.must_equal true
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
