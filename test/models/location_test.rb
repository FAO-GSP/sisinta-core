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
end
