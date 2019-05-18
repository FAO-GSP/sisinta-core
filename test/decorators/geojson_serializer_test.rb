# Testing the GeojsonSerializer module which is included in Geojson Decorators
require 'test_helper'

class GeojsonMock
  include GeojsonSerializer

  # Methods must exist for stubbing
  def features; end
end

describe GeojsonSerializer do
  subject { GeojsonMock.new }
  let(:features) { Minitest::Mock.new }

  describe '#as_json' do
    it 'delegates `features` call'
  end

  describe '#factory' do
    it 'returns an appropiate factory' do
      subject.factory.must_be_instance_of RGeo::GeoJSON::EntityFactory
    end
  end
end
