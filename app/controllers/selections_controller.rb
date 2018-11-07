# Manages the current_selection for the logged in User.

class SelectionsController < ApplicationController
  # Select a single profile.
  def update
    authorize! :update, current_user

    ids = selection_params[:profile_ids].map(&:to_i)

    if marked_for_removal?
      current_user.current_selection -= ids
    else
      current_user.current_selection += ids
    end

    # Does nothing if nothing changed.
    current_user.save

    respond_to do |format|
      format.js
    end
  end

  protected

  # Require a specific structure of params.
  def selection_params
    params.require(:selections).permit(
      :remove,
      profile_ids: []
    ).tap { |selections| selections.require(:profile_ids) }
  end

  # Typecast to boolean from the user input.
  def marked_for_removal?
    ActiveRecord::Type::Boolean.new.cast(selection_params[:remove])
  end
end
