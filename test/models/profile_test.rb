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

    it 'identifier must be unique for each user' do
      existing = create(:profile, user: user, identifier: 'something')

      build(:profile, identifier: existing.identifier).must_be :valid?
      build(:profile, user: user, identifier: existing.identifier).wont_be :valid?
    end

    it 'identifier can always be nil' do
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

    it "destroys it" do
      location = create :location, profile: subject

      subject.destroy

      location.wont_be :persisted?
    end
  end

  describe '#type' do
    it 'default to first type created' do
      type.must_be :persisted?

      Profile.new.type.must_equal type
      build(:profile).type.must_equal type
    end
  end
end
