require 'test_helper'

# :model tells Minitest it should use ActiveSupport::TestCase for this test
describe Ability, :model do
  subject { Ability.new user }

  describe 'admin' do
    let(:user) { create :admin }

    it 'can manage anything' do
      [Profile, User].each do |model|
        subject.can?(:manage, model).must_equal true
        subject.can?(:do_anything_really, model).must_equal true
      end
    end
  end

  describe 'authorized' do
    let(:user) { create :authorized }

    it 'can manage itself' do
      other_user = create(:user)

      subject.can?(:manage, user).must_equal true
      subject.can?(:manage, other_user).must_equal false
    end

    it 'can read Profiles' do
      subject.can?(:read, Profile).must_equal true
    end

    it 'can create Profiles' do
      subject.can?(:create, Profile).must_equal true
    end

    it 'can manage its own Profiles' do
      own_profile = create(:profile, user: user)
      other_profile = create(:profile)

      subject.can?(:manage, own_profile).must_equal true
      subject.can?(:manage, other_profile).must_equal false
    end
  end

  describe 'registered' do
    let(:user) { create :user }

    it 'can manage itself' do
      other_user = create(:user)

      subject.can?(:manage, user).must_equal true
      subject.can?(:manage, other_user).must_equal false
    end

    it 'can read public Profiles' do
      public_profile = create :profile, public: true
      private_profile = create :profile, public: false

      subject.can?(:read, public_profile).must_equal true
      subject.can?(:read, private_profile).must_equal false
    end
  end

  describe 'guest' do
    let(:user) { build(:user) }

    it 'can read public Profiles' do
      public_profile = create :profile, public: true
      private_profile = create :profile, public: false

      subject.can?(:read, public_profile).must_equal true
      subject.can?(:read, private_profile).must_equal false
    end
  end
end
