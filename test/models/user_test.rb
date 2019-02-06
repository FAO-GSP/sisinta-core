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

  describe '#operations' do
    it 'destroys it' do
      operation_id = create(:operation, user: subject).id

      subject.destroy

      Operation.where(id: operation_id).must_be :empty?
    end
  end

  describe '#current_selection' do
    let(:profile) { create :profile }

    it 'defaults to an empty array' do
      User.new.current_selection.must_equal []
      subject.current_selection.must_equal []
    end

    it 'does not save non existant ids' do
      subject.update_attribute :current_selection, [profile.id, profile.id + 1]

      subject.reload.current_selection.must_equal [profile.id]
    end

    it 'does not restore non existant ids' do
      subject.update_attribute :current_selection, [profile.id]
      profile.destroy

      subject.reload.current_selection.must_equal []
    end

    it 'orders itself on save' do
      3.times { create :profile }

      subject.update_attribute :current_selection, Profile.ids.sort.reverse

      subject.reload.current_selection.must_equal Profile.ids.sort
    end

    it 'normalizes itself on input without saving' do
      2.times { create :profile }

      subject.current_selection = [
        Profile.last.id,
        Profile.last.id,
        Profile.first.id,
        Profile.first.id
      ]

      subject.current_selection.must_equal [Profile.first.id, Profile.last.id]
    end

    it 'does not save duplicate ids' do
      subject.update_attribute :current_selection, [profile.id, profile.id]

      subject.reload.current_selection.must_equal [profile.id]
    end

    it 'wraps single values in arrays' do
      subject.update_attribute :current_selection, profile.id

      subject.reload.current_selection.must_equal [profile.id]
    end
  end
end
