require 'application_system_test_case'

class LayoutTest < ApplicationSystemTestCase
  let(:user) { create :user, :confirmed }
  let(:admin) { create :admin, :confirmed }

  before { visit any_path }

  describe 'search' do
    it 'can be toggled' do
      # any_path goes to profiles#index
      page.must_have_content t('profiles.index.title')
      page.must_have_selector 'form.global-search', visible: :hidden

      click_link t('layouts.navbar.search')

      page.wont_have_content t('profiles.index.title')
      page.must_have_selector 'form.global-search', visible: :visible

      click_link t('layouts.navbar.search')

      page.must_have_content t('profiles.index.title')
      page.must_have_selector 'form.global-search', visible: :hidden
    end
  end

  describe 'admin panel' do
    it 'is visible on login' do
      page.wont_have_link href: admin_root_path

      login admin

      page.must_have_link href: admin_root_path
    end

    it 'is visible only for admins' do
      page.wont_have_link href: admin_root_path

      login user

      page.wont_have_link href: admin_root_path
    end

    it 'is accessible only for admins' do
      login user

      visit admin_root_path

      page.must_have_content t('active_admin.access_denied.message')
      current_path.must_equal localized_root_path
    end
  end

  describe 'profiles' do
    describe 'global listing' do
      it 'is visible to any user' do
        click_link t('layouts.menu.profiles.title')
        page.must_have_content t('layouts.menu.profiles.index')

        login user

        click_link t('layouts.menu.profiles.title')
        page.must_have_content t('layouts.menu.profiles.index')
      end
    end

    describe 'owned profiles listing' do
      it 'is not visible to unregistered users' do
        click_link t('layouts.menu.profiles.title')
        page.wont_have_content t('layouts.menu.profiles.owned')
      end

      it 'is not visible to users who do not own profiles' do
        login user

        click_link t('layouts.menu.profiles.title')
        page.wont_have_content t('layouts.menu.profiles.owned')
      end

      it 'is visible to user who own profiles' do
        profile = create :profile

        login profile.user

        click_link t('layouts.menu.profiles.title')
        page.must_have_content t('layouts.menu.profiles.owned')
      end
    end
  end
end
