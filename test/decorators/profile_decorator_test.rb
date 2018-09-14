require 'test_helper'

class ProfileDecoratorTest < Draper::TestCase
  subject { profile.decorate }
  let(:profile) { build_stubbed :profile }

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

  describe 'contact' do
    let(:profile) { build_stubbed :profile, contact: 'someone@somewhere.com' }

    it 'returns the contact when it is present' do
      subject.contact.must_equal profile.contact
    end

    it 'returns the user email when it is not present' do
      profile.contact = nil

      subject.contact.must_equal profile.user.email
    end
  end

  describe 'coordinates' do
    let(:profile) { create(:location, :geolocated).profile }

    it 'delegates to location' do
      subject.coordinates.must_equal subject.location.coordinates
    end
  end

  describe 'user_name' do
    it 'delegates to user' do
      subject.user_name.must_equal subject.user.name
    end
  end

  describe 'license_link' do
    it 'delegates to license' do
      subject.license_link.must_equal subject.license.link
    end
  end

  describe 'license_statement' do
    it 'delegates to license' do
      subject.license_statement.must_equal subject.license.statement
    end
  end
end
