require 'test_helper'

class SelectionsHelperTest < ActionView::TestCase
  # Defining methods here allows stubbing and calling by the included module.
  def current_user
    nil
  end

  def current_ability
    Ability.new current_user
  end

  describe SelectionsHelper do
    describe '#selected_profiles' do
      it 'returns selected profiles for the current user' do
        stub :current_user, create(:user, current_selection: [1, 2]) do
          selected_profiles.must_equal [1, 2]
        end
      end

      it 'returns an empty array if there is no current user' do
        selected_profiles.must_equal []
      end
    end

    describe '#selected_profiles_for' do
      it 'returns selected profiles filtered by permission' do
        user = create :authorized
        owned = create(:profile, user: user)
        foreign = create(:profile)

        user.update current_selection: [owned.id, foreign.id]

        stub :current_user, user do
          selected_profiles_for(:manage).must_equal [owned.id]
        end
      end

      it 'returns an empty array if there is no current user' do
        selected_profiles_for(:read).must_equal []
      end
    end
  end
end
