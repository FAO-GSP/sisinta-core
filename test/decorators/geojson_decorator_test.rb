require 'test_helper'

class GeojsonDecoratorTest < Draper::TestCase
  subject { GeojsonDecorator.decorate profile }
  let(:profile) { build_stubbed(:location, :geolocated).profile }

  it 'decorates collection as GeoJSON' do
    GeojsonDecorator.decorate_collection([]).must_be_instance_of GeojsonCollectionDecorator
  end

  describe '#identifier' do
    let(:profile) { build_stubbed :profile, identifier: nil }

    it 'has a default identifier' do
      subject.identifier.wont_be :nil?
    end
  end

  describe '#properties' do
    it 'exports id attribute' do
      subject.properties[:id].must_equal profile.id
    end

    it 'exports identifier attribute' do
      subject.properties[:identifier].must_equal profile.decorate.identifier
    end

    it 'exports public attribute' do
      subject.properties[:public].must_equal profile.public
    end

    it 'exports url attribute' do
      subject.properties[:url].must_equal helpers.profile_url(profile)
    end
  end

  describe '#as_feature' do
    let(:feature) { subject.as_feature }

    it 'returns a GeoJSON Feature' do
      feature.must_be_instance_of RGeo::GeoJSON::Feature
    end

    it 'includes coordinates' do
      feature.geometry.must_equal profile.coordinates
    end

    it 'includes an id' do
      feature.feature_id.must_equal profile.id
    end
  end
end
