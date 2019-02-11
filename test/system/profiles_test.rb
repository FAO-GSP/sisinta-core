require 'application_system_test_case'

class ProfilesTest < ApplicationSystemTestCase
  let(:owned) { create :profile, source: 'owned' }
  let(:foreign) { create :profile, source: 'foreign' }

  describe 'profiles indices' do
    before do
      owned.must_be :persisted?
      foreign.must_be :persisted?

      login owned.user
    end

    describe 'owned profiles' do
      it 'lists owned profiles' do
        visit filtered_profiles_path('owned')

        page.must_have_content 'owned'
        page.wont_have_content 'foreign'
      end
    end

    describe 'global profiles' do
      it 'lists every profile' do
        visit profiles_path

        page.must_have_content 'owned'
        page.must_have_content 'foreign'
      end
    end
  end
end
