require 'test_helper'

describe Operation do
  subject { create :operation }

  describe 'validations' do
    let(:user) { create :user }

    it 'requires a user' do
      build(:operation, user: nil).wont_be :valid?
      build(:operation, user: user).must_be :valid?
    end

    it 'requires a name' do
      build(:operation, name: nil).wont_be :valid?
      build(:operation, name: 'Something').must_be :valid?
    end
  end

  describe '#finished' do
    it 'defaults to false' do
      Operation.new.wont_be :finished?
      subject.wont_be :finished?
    end
  end

  describe '#pure' do
    it 'defaults to true' do
      Operation.new.must_be :pure?
      subject.must_be :pure?
    end
  end

  describe '#profile_ids' do
    it 'defaults to an empty array' do
      Operation.new.profile_ids.must_equal []
      subject.profile_ids.must_equal []
    end
  end
end
