require 'test_helper'

describe User do
  subject { create :user }

  describe 'validations' do
    it 'requires an email' do
      build(:user, email: nil).wont_be :valid?
      build(:user, email: 'some-email@example.com').must_be :valid?
    end

    it 'requires a password' do
      build(:user, password: nil).wont_be :valid?
      build(:user, password: 'some password').must_be :valid?
    end

    it 'requires a name' do
      build(:user, name: nil).wont_be :valid?
      build(:user, name: 'Juan Salvo').must_be :valid?
    end
  end

  describe '#role' do
    subject { build :user }

    it 'defaults to :guest if not persisted' do
      subject.wont_be :persisted?

      subject.wont_be :admin?
      subject.wont_be :registered?

      subject.must_be :guest?
    end

    it 'defaults to :registered on creation' do
      subject.must_be :guest?

      subject.save

      subject.must_be :persisted?
      subject.must_be :registered?
    end

    it "can't go back to guest" do
      subject.registered!

      subject.must_be :persisted?
      subject.guest!

      subject.reload.must_be :registered?
    end
  end

  describe '.admins' do
    it 'returns only admins' do
      user = create :user
      admin = create :admin

      User.admins.count.must_equal 1
      User.admins.include?(admin).must_equal true
      User.admins.include?(user).wont_equal true
    end
  end

  describe '#profiles' do
    it 'restricts destruction with error if there are any' do
      create :profile, user: subject

      subject.destroy

      subject.errors.wont_be :empty?
    end
  end
end
