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
      get profile_path profile.to_param

      must_respond_with :success
    end

    it 'gets a geojson response' do
      get profile_path profile.to_param, format: :geojson

      must_respond_with :success
    end
  end
end
