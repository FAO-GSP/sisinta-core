# Manages the current_selection for the logged in User.

class SelectionsController < ApplicationController
  # Select a single profile.
  def update
    authorize! :update, current_user

    if selection_params[:profile_ids].present?
      current_user.current_selection += selection_params[:profile_ids].map(&:to_i)

      current_user.save
    end

    respond_to do |format|
      format.js
    end
  end

  protected

  def selection_params
    params.require(:selections).permit(
      profile_ids: []
    )
  end
end
