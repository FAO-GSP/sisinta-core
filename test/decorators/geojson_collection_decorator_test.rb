require 'test_helper'

class GeojsonCollectionDecoratorTest < Draper::TestCase
  subject { GeojsonCollectionDecorator.decorate Profile.where(id: profile.id) }
  let(:profile) { create :profile, location: build(:location, :geolocated) }

  it 'decorates items as GeoJSON' do
    subject.first.must_be_instance_of GeojsonProfileDecorator
  end

  describe '#as_json' do
    it 'returns a serializable hash' do
      subject.as_json.must_be_instance_of Hash
    end

    it 'returns a collection of features' do
      subject.as_json['type'].must_equal 'FeatureCollection'
      subject.as_json['features'].size.must_equal subject.features.size
    end
  end

  describe '#features' do
    it 'returns a collection of pregenerated GeoJSON features' do
      subject.features.each do |feature|
        feature.must_be_instance_of Hash
        feature['type'].must_equal 'Feature'
      end
    end
  end
end
