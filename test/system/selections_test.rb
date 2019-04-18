require 'application_system_test_case'

class SelectionsTest < ApplicationSystemTestCase
  subject { create :user, :confirmed }
  let(:profile) { create :profile }

  describe 'select profiles with the toolbar' do
    before { login subject }

    it 'adds ids' do
      profile.must_be :persisted?

      # Preserves profile.id in the session hash.
      visit profiles_path
      click_button t('profiles.index.select_all')

      page.must_have_content t('selections.update.selected_profiles', count: 1)

      subject.reload.current_selection.must_equal [profile.id]
    end

    it 'removes ids' do
      subject.update_attribute :current_selection, [profile.to_param]

      # Preserves profile.id in the session hash.
      visit profiles_path
      click_button t('profiles.index.select_none')

      page.must_have_content t('selections.update.selected_profiles', count: 0)

      subject.reload.current_selection.must_be :empty?
    end
  end
end
