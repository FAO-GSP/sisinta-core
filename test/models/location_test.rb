require 'test_helper'

describe Location do
  describe 'validations' do
    let(:profile) { create :profile }

    it 'requires a profile' do
      build(:location, profile: nil).wont_be :valid?
      build(:location, profile: profile).must_be :valid?
    end

    it 'can only be one per profile' do
      existing = create(:location)

      build(:location, profile: existing.profile).wont_be :valid?
    end
  end
end
