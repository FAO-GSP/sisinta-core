require 'test_helper'

describe User do
  subject { build :user }

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

  describe '.admins' do
    it 'returns only admins' do
      user = create :user
      admin = create :admin

      User.admins.count.must_equal 1
      User.admins.include?(admin).must_equal true
      User.admins.include?(user).wont_equal true
    end
  end

  describe '#role' do
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

  describe '#profiles' do
    subject { create :user }

    it 'restricts destruction with error if there are any' do
      create :profile, user: subject

      subject.destroy

      subject.errors.wont_be :empty?
    end
  end

  describe '#current_selection' do
    it 'defaults to an empty array' do
      subject.current_selection.must_equal []
    end

    it 'orders itself on save' do
      subject.update_attribute :current_selection, [3, 2, 1]

      subject.reload.current_selection.must_equal [1, 2, 3]
    end

    it 'normalizes itself on input' do
      subject.current_selection = [3, 2, 2, 1]

      subject.current_selection.must_equal [1, 2, 3]
    end

    it 'does not save duplicate ids' do
      subject.update_attribute :current_selection, [1, 1, 1]

      subject.reload.current_selection.must_equal [1]
    end

    it 'wraps single values in arrays' do
      subject.update_attribute :current_selection, 1

      subject.reload.current_selection.must_equal [1]
    end
  end
end
