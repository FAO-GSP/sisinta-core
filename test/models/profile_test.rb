require 'test_helper'

describe Profile do
  subject { create :profile }

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
end
