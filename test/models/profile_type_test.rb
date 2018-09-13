require 'test_helper'

describe ProfileType do
  subject { create :profile_type }

  describe 'validations' do
    it 'requires unique values' do
      existing = create :profile_type

      build(:profile_type, value: existing.value).wont_be :valid?
    end

    it 'requires a value' do
      build(:profile_type, value: nil).wont_be :valid?
      build(:profile_type, value: 'something').must_be :valid?
    end

    it 'requires a default value' do
      build(:profile_type, default: nil).wont_be :valid?
      build(:profile_type, default: true).must_be :valid?
    end

    it 'requires a default' do
      ProfileType.where(default: true).must_be :empty?

      build(:profile_type, default: false).wont_be :valid?
      build(:profile_type, default: true).must_be :valid?
    end
  end

  describe '#default' do
    let(:existing_default) { create :profile_type, default: true }

    it 'returns the default' do
      existing_default.must_be :persisted?

      ProfileType.default.must_equal existing_default
    end

    it 'replaces exising defaults with a new one' do
      existing_default.must_be :persisted?

      new_default = create :profile_type, default: true

      existing_default.reload.wont_be :default?
      ProfileType.default.must_equal new_default
    end
  end

  describe '#profiles' do
    it 'restricts destruction with error if there are any' do
      create :profile, type: subject

      subject.destroy

      subject.errors.wont_be :empty?
    end
  end
end
