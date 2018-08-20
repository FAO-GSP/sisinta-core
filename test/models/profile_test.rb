require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  describe 'validations' do
    let(:user) { create :user }

    it 'requires a user' do
      build(:profile, user: nil).wont_be :valid?
      build(:profile, user: user).must_be :valid?
    end
  end

  describe 'public' do
    it 'defaults to true' do
      Profile.new.must_be :public?
    end
  end
end
