# Manages the current_selection for the logged in User.

class SelectionsController < ApplicationController
  # Select a single profile.
  def update
    authorize! :update, current_user

    ids =
      if load_from_session?
        # Take the ids from session, preserved by ProfilesController from the
        # previous search.
        decompress session[:previous_profile_ids]
      else
        selection_params[:profile_ids].map(&:to_i)
      end

    if marked_for_removal?
      current_user.current_selection -= ids
    else
      current_user.current_selection += ids
    end

    # Does nothing if nothing changed.
    current_user.save

    respond_to do |format|
      format.js
      format.html do
        flash[:notice] = I18n.t('selections.update.selected_profiles', count: current_user.current_selection.size)
        redirect_to_back
      end
    end
  end

  protected

  # Require a specific structure of params.
  def selection_params
    params.require(:selections).permit(
      :remove, :session,
      profile_ids: []
    )
  end

  # Typecast to boolean from the user input.
  def marked_for_removal?
    ActiveRecord::Type::Boolean.new.cast(selection_params[:remove])
  end

  def load_from_session?
    ActiveRecord::Type::Boolean.new.cast(selection_params[:session])
  end
end
