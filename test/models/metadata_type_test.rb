require 'test_helper'

describe MetadataType do
  describe 'validations' do
    it 'requires a field_name' do
      build(:metadata_type, field_name: 'something').must_be :valid?
      build(:metadata_type, field_name: nil).wont_be :valid?
    end

    it 'requires a value' do
      build(:metadata_type, value: 'something').must_be :valid?
      build(:metadata_type, value: nil).wont_be :valid?
    end

    it 'has a unique value scoped per field_name' do
      existing = create :metadata_type, field_name: 'a field', value: 'a value'

      build(:metadata_type, value: existing.value).must_be :valid?
      build(:metadata_type, field_name: existing.field_name, value: existing.value).wont_be :valid?
    end
  end
end
