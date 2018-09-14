require 'test_helper'

class ProfileTypeDecoratorTest < Draper::TestCase
  subject { profile_type.decorate }
  let(:profile_type) { build_stubbed :profile_type }

  describe 'to_s' do
    it 'returns the value' do
      subject.to_s.must_equal subject.value
    end
  end

  describe 'value' do
    it 'titleizes the value' do
      subject.value.must_equal profile_type.value.titleize
    end
  end
end
