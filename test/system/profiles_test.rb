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

  describe 'new' do
    let(:authorized) { create :authorized, :confirmed }
    let(:registered) { create :user, :confirmed }

    describe 'when logged in as authorized' do
      it 'can create profiles' do
        login authorized
        visit profiles_path

        page.must_have_link I18n.t('new'), href: new_profile_path
      end
    end

    describe 'when not authorized' do
      it 'cannot create profiles' do
        # Guest
        visit profiles_path

        page.wont_have_link I18n.t('new'), href: new_profile_path

        login registered
        visit profiles_path

        page.wont_have_link I18n.t('new'), href: new_profile_path
      end
    end
  end
end
