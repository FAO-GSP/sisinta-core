require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
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
  end

  describe '#public' do
    it 'defaults to true' do
      Profile.new.must_be :public?
    end
  end
end
