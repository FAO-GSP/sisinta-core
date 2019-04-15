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

    it 'does not allow more than one Entry per field_name in MetadataType in a profile' do
      invalid_type = create(:metadata_type, field_name: type.field_name)

      build(:metadata_entry, profile: profile, metadata_type: invalid_type).must_be :valid?

      create(:metadata_entry, profile: profile, metadata_type: type)

      build(:metadata_entry, profile: profile, metadata_type: invalid_type).wont_be :valid?
    end
  end
end
