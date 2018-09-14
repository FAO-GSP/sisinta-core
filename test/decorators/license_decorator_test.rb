require 'test_helper'

class LicenseDecoratorTest < Draper::TestCase
  subject { license.decorate }
  let(:license) { build_stubbed :license }

  describe 'full_name' do
    it 'includes the name and acronym' do
      subject.full_name.must_match license.name
      subject.full_name.must_match license.acronym
    end
  end

  describe 'statement' do
    it 'returns safe html' do
      subject.statement.must_be :html_safe?
    end
  end

  describe 'link' do
    it 'returns a link to url' do
      subject.link.must_match subject.full_name
      subject.link.must_match "href=\"#{subject.url}\""
    end
  end
end
