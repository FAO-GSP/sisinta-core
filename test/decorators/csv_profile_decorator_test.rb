require 'test_helper'

class CsvProfileDecoratorTest < Draper::TestCase
  subject { CsvProfileDecorator.decorate profile }
  let(:profile) { create :profile, layers_count: 2 }

  it 'decorates collection as CsvDecorator' do
    CsvProfileDecorator.decorate_collection([]).must_be_instance_of CsvDecorator
  end

  it 'decorates layers with CsvLayerDecorator' do
    subject.layers.first.must_be_instance_of CsvLayerDecorator
  end

  describe '#profile_identifier' do
    it 'returns the identifier' do
      subject.profile_identifier.must_equal profile.decorate.identifier
    end
  end

  describe '#type' do
    it 'returns the translated profile type' do
      subject.type.must_equal profile.type.value
    end
  end

  describe '#license' do
    it 'returns the license acronym' do
      subject.license.must_equal profile.license.acronym
    end
  end

  describe '#rows' do
    it 'returns a collection of field rows' do
      subject.rows.each do |row|
        row.must_be_instance_of CSV::Row
        row.must_be :field_row?
      end
    end

    it 'returns a row per layer' do
      profile.layers.count.must_equal 2
      subject.rows.size.must_equal 2
    end

    it 'adds extra attributes to each row' do
      subject.rows(extra: { something: :new }).each do |row|
        row[:something].must_equal :new
      end
    end

    it 'filters its own attributes' do
      subject.rows(filter: { profile: { only: [:source] } }).each do |row|
        row['source'].must_equal profile.decorate.source
        row['profile_identifier'].must_be :nil?
      end
    end

    it 'filters its layers attributes' do
      rows = subject.rows(filter: { layer: { only: [:top] } })
        
      rows.first['top'].must_equal profile.decorate.layers.first.top
      rows.last['top'].must_equal profile.decorate.layers.last.top

      rows.each do |row|
        row['bottom'].must_be :nil?
      end
    end

    describe 'when empty' do
      let(:profile) { create :profile, layers_count: 0, order: 'something' }

      it 'returns a single row if there are no layers' do
        profile.layers.count.must_equal 0
        subject.rows.size.must_equal 1
      end

      it 'exports profile attributes even if there are no rows' do
        subject.rows.first['order'].must_equal 'something'
      end
    end
  end

  describe '#serializable_hash' do
    let(:profile) { create :profile, :complete }

    it 'returns every exportable attribute decorated by default' do
      # Reload virtual attributes.
      # TODO Maybe change the way latitude and longitude are derived from coordinates.
      profile.location.reload

      attributes = %w{
        latitude
        longitude
        country_code
        date
        order
        source
        contact
      }

      hash = subject.serializable_hash

      attributes.each do |key|
        hash.keys.include?(key).must_equal true, "Should include #{key}"
        hash[key].wont_equal nil, "Should have a value for #{key}"
        hash[key].must_equal profile.decorate.send(key), "Attribute #{key} doesn't match"
      end
    end

    it 'exports selected attributes' do
      hash = subject.serializable_hash(filter: {
        only: [:country_code, :order]
      })

      %w{country_code order}.each do |key|
        hash[key].must_equal profile.send(key), "Attribute #{key} doesn't match"
      end

      hash['latitude'].must_be :nil?
      hash['longitude'].must_be :nil?
      hash['source'].must_be :nil?
    end

    it 'adds extra attributes' do
      hash = subject.serializable_hash(extra: { some_attribute: 'added' })

      hash[:some_attribute].must_equal 'added'
    end
  end
end
