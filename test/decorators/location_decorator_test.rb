require 'test_helper'

class LocationDecoratorTest < Draper::TestCase
  subject { location_tested.decorate }
  # Minitest reserves `location` as a name
  let(:location_tested) { create(:location, :geolocated).reload }

  describe '#coordinates' do
    it 'returns them as a pair of latitude, longitude' do
      subject.coordinates.split(',').first.must_match location_tested.latitude.to_s
      subject.coordinates.split(',').last.must_match location_tested.longitude.to_s
    end

    it 'returns nil if there are no coordinates' do
      not_geolocated = create(:location).decorate

      not_geolocated.coordinates.must_be :nil?
    end
  end

  describe '#coordinates_array' do
    it 'returns them as an array' do
      subject.coordinates_array.first.must_equal location_tested.latitude
      subject.coordinates_array.last.must_equal location_tested.longitude
    end
  end
end
