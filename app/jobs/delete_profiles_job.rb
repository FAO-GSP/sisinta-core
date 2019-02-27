# Deletes selected profiles in batches.

class DeleteProfilesJob < ApplicationJob
  include GeojsonCache

  def perform(operation)
    # Setup this user's permissions.
    ability = Ability.new operation.user

    # Filter profiles to those allowed for destruction. 
    destroyable_profiles = Profile.where(id: operation.profile_ids).accessible_by(ability, :destroy)

    # TODO Try to rescue and recover/report.
    destroyable_profiles.find_each do |profile|
      # Instantiate and destroy each record, thus calling callbacks.
      profile.destroy!
    end

    operation.update finished: true
  end
end
