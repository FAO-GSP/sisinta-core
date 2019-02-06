# Helpers for selected profiles.

module SelectionsHelper
  # Safely access currently selected profiles.
  def selected_profiles
    current_user.try(:current_selection) || []
  end

  # Safely access selected profiles accessible for a given action.
  def selected_profiles_for(action)
    Profile.where(id: selected_profiles).accessible_by(current_ability, action).ids
  end
end
