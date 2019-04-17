require 'test_helper'

describe Profile do
  subject { create :profile }
  let(:type) { create :profile_type }
  let(:license) { create :license}

  describe 'validations' do
    let(:user) { create :user }

    it 'requires a user' do
      build(:profile, user: nil).wont_be :valid?
      build(:profile, user: user).must_be :valid?
    end

    it 'has a unique identifier scoped per user' do
      existing = create(:profile, user: user, identifier: 'something')

      build(:profile, identifier: existing.identifier).must_be :valid?
      build(:profile, user: user, identifier: existing.identifier).wont_be :valid?
    end

    it 'can have a nil identifier' do
      build(:profile, identifier: nil).must_be :valid?
      build(:profile, user: user, identifier: nil).must_be :valid?
    end

    it 'can have a nil identifier regardless of duplication' do
      existing = create(:profile, user: user, identifier: nil)

      build(:profile, user: user, identifier: existing.identifier).must_be :valid?
    end

    it 'requires a source' do
      build(:profile, source: nil).wont_be :valid?
      build(:profile, source: 'the organization').must_be :valid?
    end

    it 'requires a type' do
      build(:profile, type: nil).wont_be :valid?
      build(:profile, type: type).must_be :valid?
    end

    it 'requires a license' do
      build(:profile, license: nil).wont_be :valid?
      build(:profile, license: license).must_be :valid?
    end

    it 'requires a country code' do
      build(:profile, country_code: nil).wont_be :valid?
      build(:profile, country_code: 'ARG').must_be :valid?
    end

    it 'requires a country code from a list of valid codes' do
      build(:profile, country_code: 'not').wont_be :valid?

      Rails.configuration.engine.default_country_codes.each do |code|
        build(:profile, country_code: code).must_be :valid?
      end
    end

    it 'has a unique uuid' do
      existing = create(:profile, uuid: 'something')

      build(:profile, uuid: 'something else').must_be :valid?
      build(:profile, uuid: existing.uuid).wont_be :valid?
    end
  end

  describe '#public' do
    it 'defaults to true' do
      Profile.new.must_be :public?
      subject.must_be :public?
    end
  end

  describe '#location' do
    it 'can create a location' do
      subject.location.must_be :nil?

      subject.update location_attributes: attributes_for(:location, :geolocated)

      subject.reload.location.wont_be :nil?
    end

    it 'destroys it' do
      location_id = create(:location, profile: subject).id

      subject.destroy

      Location.where(id: location_id).must_be :empty?
    end
  end

  describe '#layers' do
    it 'can create layers' do
      subject.layers.must_be :empty?

      subject.update layers_attributes: [attributes_for(:layer)]

      subject.reload.layers.wont_be :empty?
    end

    it 'destroys it' do
      layer_id = create(:layer, profile: subject).id

      subject.destroy

      Layer.where(id: layer_id).must_be :empty?
    end
  end

  describe '#type' do
    it 'default to first type created' do
      type.must_be :persisted?

      Profile.new.type.must_equal type
      build(:profile).type.must_equal type
    end
  end

  describe '#metadata' do
    let(:type_one) { create :metadata_type, field_name: MetadataType::FIELD_NAMES.first }
    let(:type_two) { create :metadata_type, field_name: MetadataType::FIELD_NAMES.second }

    it 'saves a metadata types id' do
      subject.metadata_entries.must_be :empty?

      subject.update metadata: type_one.id

      subject.metadata_entries.size.must_equal 1
      subject.metadata_types.size.must_equal 1
      subject.metadata_types.must_include type_one
    end

    it 'saves an array of metadata types ids' do
      subject.metadata_entries.must_be :empty?

      subject.update metadata: [type_one.id, type_two.id]

      subject.metadata_entries.size.must_equal 2
      subject.metadata_types.size.must_equal 2
      subject.metadata_types.must_include type_one
      subject.metadata_types.must_include type_two
    end

    it 'replaces existing metadata with the whole array' do
      subject.update metadata: type_one.id

      subject.update metadata: type_two.id

      subject.metadata_types.wont_include type_one
      subject.metadata_types.must_include type_two
    end

    it 'does not change metadata if nil given' do
      subject.update metadata: type_one.id

      subject.update metadata: nil

      subject.reload.metadata_types.must_include type_one
    end

    it 'does not change metadata if empty array given' do
      subject.update metadata: type_one.id

      subject.update metadata: []

      subject.reload.metadata_types.must_include type_one
    end

    it 'validates generated metadata_entries' do
      repeated_field = create :metadata_type, field_name: type_one.field_name

      # Repeated MetadataType should be invalid
      subject.assign_attributes metadata: [type_one.id, repeated_field.id], source: 'sarasa'

      subject.save

      subject.wont_be :valid?
      subject.errors.messages[:metadata_entries].wont_be :empty?
    end
  end

  describe '#metadata_entries' do
    it 'destroys them' do
      entry_id = create(:metadata_entry, profile: subject).id

      subject.destroy

      MetadataEntry.where(id: entry_id).must_be :empty?
    end
  end

  describe '.geolocated' do
    it 'only returns objects with location and coordinates' do
      # not geolocated profiles
      create :profile, location: nil
      create :profile, location_attributes: attributes_for(:location)

      geolocated = create :profile, location_attributes: attributes_for(:location, :geolocated)

      Profile.count.must_equal 3
      Profile.geolocated.count.must_equal 1
      Profile.geolocated.include?(geolocated).must_equal true
    end
  end

  describe '.generate_uuid' do
    let(:params) do
      {
        country_code: 'a',
        identifier: 'b',
        source: 'c',
        latitude: 'd',
        longitude: 'e'
      }
    end

    it 'generates identical UUIDs for repeated values' do
      Profile.generate_uuid(params).must_equal Profile.generate_uuid(params.dup)
    end

    it 'generates different UUIDs for different input values' do
      different_params = params.merge({ country_code: 'other' })

      Profile.generate_uuid(params).wont_equal Profile.generate_uuid(different_params)
    end
  end
end
