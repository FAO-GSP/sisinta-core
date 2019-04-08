require 'test_helper'

describe MetadataType do
  describe 'validations' do
    it 'requires a field_name' do
      build(:metadata_type, field_name: MetadataType::FIELD_NAMES.sample).must_be :valid?
      build(:metadata_type, field_name: nil).wont_be :valid?
    end

    it 'requires field_name is one of the allowed field names' do
      build(:metadata_type, field_name: 'something').wont_be :valid?

      MetadataType::FIELD_NAMES.each do |field_name|
        build(:metadata_type, field_name: field_name).must_be :valid?
      end
    end

    it 'requires a value' do
      build(:metadata_type, value: 'something').must_be :valid?
      build(:metadata_type, value: nil).wont_be :valid?
    end

    it 'has a unique value scoped per field_name' do
      a_field, other_field = MetadataType::FIELD_NAMES.sample 2

      existing = create :metadata_type, field_name: a_field, value: 'a value'

      build(:metadata_type, field_name: other_field, value: existing.value).must_be :valid?
      build(:metadata_type, field_name: existing.field_name, value: existing.value).wont_be :valid?
    end
  end
end
