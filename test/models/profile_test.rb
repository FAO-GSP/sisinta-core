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
      create(:profile, user: user, identifier: nil)

      build(:profile, identifier: nil).must_be :valid?
      build(:profile, user: user, identifier: nil).must_be :valid?
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
end
