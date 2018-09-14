require 'test_helper'

class ProfileDecoratorTest < Draper::TestCase
  subject { profile.decorate }

  describe 'identifier' do
    let(:profile) { build_stubbed :profile, identifier: nil }

    it 'has a default identifier' do
      subject.identifier.wont_be :nil?
    end
  end

  describe 'date' do
    let(:profile) { build_stubbed :profile, date: Date.today }

    it 'localizes the date' do
      h = Minitest::Mock.new
      h.expect :l, 'localized date', [profile.date]

      subject.stub :h, h do
        subject.date
      end

      h.verify
    end
  end

  describe 'country' do
    let(:profile) { build_stubbed :profile, country_code: 'ARG' }

    it 'returns a country name' do
      subject.country.must_equal 'Argentina'
    end
  end
end
