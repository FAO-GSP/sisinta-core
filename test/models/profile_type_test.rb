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
  end

  describe '#default' do
    it 'defaults to first type' do
      create :profile_type, value: 'first'
      create :profile_type, value: 'second'

      ProfileType.default.value.must_equal 'first'
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
