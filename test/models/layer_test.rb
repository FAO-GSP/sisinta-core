require 'test_helper'

describe Layer do
  subject { create :layer }

  describe 'validations' do
    let(:profile) { create :profile }

    it 'requires an identifier' do
      build(:layer, identifier: nil).wont_be :valid?
    end

    # Regression test. Some data comes without bounds if it is only one layer.
    it 'does not requires top' do
      build(:layer, top: nil).must_be :valid?
    end

    # Regression test. Some data comes without lower bounds for the deepest
    # layer.
    it 'does not require bottom' do
      build(:layer, bottom: nil).must_be :valid?
    end

    it 'requires a profile' do
      build(:layer, profile: nil).wont_be :valid?
    end

    it 'has a unique identifier scoped per profile' do
      existing = create(:layer, profile: profile, identifier: 'something')

      build(:layer, identifier: existing.identifier).must_be :valid?
      build(:layer, profile: profile, identifier: existing.identifier).wont_be :valid?
    end
  end
end
