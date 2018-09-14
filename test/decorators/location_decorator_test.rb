require 'test_helper'

class LocationDecoratorTest < Draper::TestCase
  subject { decorated.decorate }

  describe 'coordinates' do
    let(:decorated) { create(:location, :geolocated).reload }

    it 'returns them as a pair of latitude, longitude' do
      subject.coordinates.split(',').first.must_match decorated.latitude.to_s
      subject.coordinates.split(',').last.must_match decorated.longitude.to_s
    end
  end
end
