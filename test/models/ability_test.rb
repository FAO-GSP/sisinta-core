require 'test_helper'

# :model tells Minitest it should use ActiveSupport::TestCase for this test
describe Ability, :model do
  subject { Ability.new user }

  describe 'admin' do
    let(:user) { create :admin }

    it 'can manage anything' do
      [Profile, User, Location].each do |model|
        subject.can?(:manage, model).must_equal true
        subject.can?(:do_anything_really, model).must_equal true
      end
    end
  end

  describe 'authorized' do
    let(:user) { create :authorized }

    it 'can read, update and delete themselves' do
      other_user = create(:user)

      [:read, :update, :destroy].each do |action|
        subject.can?(action, user).must_equal true,
          "Should be able to #{action} themselves."
        subject.can?(action, other_user).must_equal false,
          "Should not be able to #{action} other users."
      end
    end

    it 'can read any Profile' do
      subject.can?(:read, Profile).must_equal true
      subject.can?(:read, create(:profile, public: true)).must_equal true
      subject.can?(:read, create(:profile, public: false)).must_equal true
    end

    it 'can create Profiles' do
      subject.can?(:create, Profile).must_equal true
    end

    it 'can manage their own Profiles' do
      own_profile = create(:profile, user: user)
      other_profile = create(:profile)

      subject.can?(:manage, own_profile).must_equal true
      subject.can?(:manage, other_profile).must_equal false
    end
  end

  describe 'registered' do
    let(:user) { create :user }

    it 'can read, update and delete themselves' do
      other_user = create(:user)

      [:read, :update, :destroy].each do |action|
        subject.can?(action, user).must_equal true,
          "Should be able to #{action} themselves."
        subject.can?(action, other_user).must_equal false,
          "Should not be able to #{action} other users."
      end
    end

    it 'can read public Profiles' do
      public_profile = create :profile, public: true
      private_profile = create :profile, public: false

      subject.can?(:read, public_profile).must_equal true
      subject.can?(:read, private_profile).must_equal false
    end

    it "can't create Profiles" do
      subject.can?(:create, Profile).must_equal false
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
