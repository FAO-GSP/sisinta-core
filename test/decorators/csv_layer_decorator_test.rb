require 'test_helper'

class CsvLayerDecoratorTest < Draper::TestCase
  subject { CsvLayerDecorator.decorate layer }
  let(:layer) { create :layer, designation: 'first!' }

  describe '#row' do
    it 'returns a single field row' do
      subject.row.must_be_instance_of CSV::Row
      subject.row.must_be :field_row?
    end
  end

  describe '#layer_identifier' do
    it 'returns the identifier' do
      subject.layer_identifier.must_equal layer.decorate.identifier
    end
  end

  describe '#serializable_hash' do
    let(:layer) { create :layer, :complete }

    it 'returns every exportable attribute decorated by default' do
      attributes = %w{
        top
        bottom
        designation
        bulk_density
        ca_co3
        coarse_fragments
        ecec
        conductivity
        organic_carbon
        ph_h2o_1
        ph_h2o_2_5
        ph_kcl_1
        ph_kcl_2_5
        clay
        silt
        sand
        water_retention
      }

      hash = subject.serializable_hash

      attributes.each do |key|
        hash.keys.include?(key).must_equal true
        hash[key].must_equal layer.decorate.send(key), "Attribute #{key} doesn't match"
      end
    end

    it 'exports selected attributes' do
      hash = subject.serializable_hash(filter: {
        only: [:top, :bottom]
      })

      %w{top bottom}.each do |key|
        hash[key].must_equal layer.send(key), "Attribute #{key} doesn't match"
      end

      hash['layer_identifier'].must_be :nil?
      hash['sand'].must_be :nil?
    end

    it 'adds extra attributes' do
      hash = subject.serializable_hash(extra: { some_attribute: 'added' })

      hash[:some_attribute].must_equal 'added'
    end
  end
end
