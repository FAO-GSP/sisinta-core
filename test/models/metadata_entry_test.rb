require 'test_helper'

describe MetadataEntry do
  let(:type) { create :metadata_type }
  let(:profile) { create :profile }

  describe 'validations' do
    it 'does not allow repeated pairs of [profile, metadata_type]' do
      build(:metadata_entry, profile: profile, metadata_type: type).must_be :valid?

      create(:metadata_entry, profile: profile, metadata_type: type)

      build(:metadata_entry, profile: profile, metadata_type: type).wont_be :valid?
    end

    it 'allows editing the same entry with a differente type' do
      entry = create(:metadata_entry, profile: profile, metadata_type: type)

      entry.update_attribute :metadata_type_id, create(:metadata_type).id

      entry.must_be :valid?
    end

    it 'does not allow more than one Entry per field_name in MetadataType in a profile' do
      repeated_type = create(:metadata_type, field_name: type.field_name)

      build(:metadata_entry, profile: profile, metadata_type: repeated_type).must_be :valid?

      create(:metadata_entry, profile: profile, metadata_type: type)

      build(:metadata_entry, profile: profile, metadata_type: repeated_type).wont_be :valid?
    end
  end
end
