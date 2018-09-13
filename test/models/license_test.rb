require 'test_helper'

describe License do
  subject { create :license }

  describe 'validations' do
    it 'requires a unique name' do
      build(:license, name: subject.name).wont_be :valid?
    end

    it 'requires a unique url' do
      build(:license, url: subject.url).wont_be :valid?
    end

    it 'requires a unique acronym' do
      build(:license, acronym: subject.acronym).wont_be :valid?
    end

    it 'requires a unique statement' do
      build(:license, statement: subject.statement).wont_be :valid?
    end

    it 'requires a name' do
      build(:license, name: nil).wont_be :valid?
      build(:license, name: 'something').must_be :valid?
    end

    it 'requires a url' do
      build(:license, url: nil).wont_be :valid?
      build(:license, url: 'something').must_be :valid?
    end

    it 'requires a acronym' do
      build(:license, acronym: nil).wont_be :valid?
      build(:license, acronym: 'something').must_be :valid?
    end

    it 'requires a statement' do
      build(:license, statement: nil).wont_be :valid?
      build(:license, statement: 'something').must_be :valid?
    end

    it 'requires a default value' do
      build(:license, default: nil).wont_be :valid?
      build(:license, default: true).must_be :valid?
    end

    it 'requires a default' do
      License.where(default: true).must_be :empty?

      build(:license, default: false).wont_be :valid?
      build(:license, default: true).must_be :valid?
    end
  end

  describe '#default' do
    let(:existing_default) { create :license, default: true }

    it 'returns the default' do
      existing_default.must_be :persisted?

      License.default.must_equal existing_default
    end

    it 'replaces exising defaults with a new one' do
      existing_default.must_be :persisted?

      new_default = create :license, default: true

      existing_default.reload.wont_be :default?
      License.default.must_equal new_default
    end
  end

  describe '#profiles' do
    it 'restricts destruction with error if there are any' do
      create :profile, license: subject

      subject.destroy

      subject.errors.wont_be :empty?
    end
  end
end
