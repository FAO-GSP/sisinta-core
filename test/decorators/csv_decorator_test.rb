require 'test_helper'

class CsvDecoratorTest < Draper::TestCase
  subject { CsvDecorator.decorate [first_profile, second_profile] }
  let(:first_layer) { create :layer, designation: 'first!' }
  let(:second_layer) { create :layer, designation: 'second!' }
  let(:first_profile) { first_layer.profile }
  let(:second_profile) { second_layer.profile }

  it 'decorates items as CsvProfileDecorator' do
    subject.first.must_be_instance_of CsvProfileDecorator
  end

  describe '#as_csv' do
    it 'returns a csv string' do
      subject.as_csv.must_be_instance_of String
    end

    it 'returns layers as csv' do
      first_layer.must_be :persisted?
      second_layer.must_be :persisted?

      subject.as_csv.must_match /first!/
      subject.as_csv.must_match /second!/
    end

    it 'returns a line per layer' do
      first_layer.must_be :persisted?
      second_layer.must_be :persisted?

      subject.as_csv(write_headers: false).split("\n").size.must_equal 2
    end

    it 'returns a csv with header row by default' do
      %w{
        profile_identifier
        layer_identifier
        latitude
        longitude
        country_code
        top
        bottom
        date
        type
        order
        source
        contact
        license
        designation
        bulk_density
        ca_co3
        coarse_fragments
        ecec
        conductivity
        organic_carbon
        ph
        clay
        silt
        sand
        water_retention
      }.each do |column|
        subject.as_csv.must_match column, "Should have a header '#{column}'."
        subject.as_csv(write_headers: false).wont_match column, "Should not have a header '#{column}'."
      end
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
      first_layer.must_be :persisted?
      second_layer.must_be :persisted?

      subject.rows.size.must_equal 2
    end

    it 'accepts a block for processing each row' do
      returned = subject.rows do |row|
        row['designation'] = 'replaced!'
      end

      returned.all? { |row| row['designation'].must_equal 'replaced!' }
    end

    describe 'when empty' do
      let(:first_profile) { create :profile, layers_count: 0, order: 'something' }
      let(:second_profile) { create :profile, layers_count: 0, order: 'else' }

      it 'returns a row per profile without layers' do
        Layer.count.must_equal 0
        subject.rows.size.must_equal 2
      end
    end
  end
end
