require 'test_helper'

describe Location do
  subject { create :location }

  describe 'validations' do
    let(:profile) { create :profile }

    it 'requires a profile' do
      build(:location, profile: nil).wont_be :valid?
      build(:location, profile: profile).must_be :valid?
    end

    it 'can only be one per profile' do
      existing = create(:location)

      build(:location, profile: existing.profile).wont_be :valid?
    end

    it 'requires latitude within certain range' do
      valid = %w{85.0511287 50 0 -50 -85.0511287}
      invalid = %w{90 85.05112870001 -85.05112870001 -90}

      valid.each do |value|
        build(:location, latitude: value, longitude: 0).must_be :valid?, value
      end

      invalid.each do |value|
        build(:location, latitude: value, longitude: 0).wont_be :valid?, value
      end
    end

    it 'requires longitude within certain range' do
      valid = %w{180 50 0 -50 -180}
      invalid = %w{180.0001 -180.0001}

      valid.each do |value|
        build(:location, longitude: value, latitude: 0).must_be :valid?, value
      end

      invalid.each do |value|
        build(:location, longitude: value, latitude: 0).wont_be :valid?, value
      end
    end
  end

  describe '#coordinates' do
    it 'can handle latitude' do
      subject.latitude = 10
      subject.latitude.must_equal 10
    end

    it 'can handle longitude' do
      subject.longitude = 10
      subject.longitude.must_equal 10
    end

    it 'creates them with latitude and longitude separately' do
      location = create :location, latitude: 15, longitude: 30

      location.coordinates.must_be :present?
      location.coordinates.latitude.must_equal 15
      location.coordinates.longitude.must_equal 30
    end

    it 'can access latitude and longitude directly' do
      location = create :location, :geolocated

      # reload doesn't trigger after_initialize
      location = Location.find(location.id)

      location.latitude.must_equal location.coordinates.latitude
      location.longitude.must_equal location.coordinates.longitude
    end
  end

  describe '#geolocated?' do
    it 'is geolocated only if it has coordinates' do
      build(:location, :geolocated).must_be :geolocated?
      build(:location).wont_be :geolocated?
    end
  end

  describe '.factory' do
    subject { Location.factory }

    it 'is geographic' do
      subject.must_be_instance_of RGeo::Geographic::Factory
    end

    it 'has a projection factory' do
      subject.projection_factory.must_be :present?
    end

    it 'uses EPSG:4326' do
      subject.srid.must_equal 4326
    end
  end
end
