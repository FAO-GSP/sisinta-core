class ProfilesController < ApplicationController
  include GeojsonCache

  before_action :setup_profiles, only: :index
  load_and_authorize_resource only: [:show, :destroy]

  decorates_assigned :profile, :profiles

  def index
    respond_to do |format|
      format.html do
        # Preserve all the ids for selection in SelectionsController.
        session[:previous_profile_ids] = compress(@profiles.ids)
        # Return paginated and decorated objects to view.
        @profiles = @profiles.page(params[:page]).per(params[:page_size])
      end

      format.geojson do
        # Return every Profile with coordinates.
        render json: GeojsonCollectionDecorator.decorate(@profiles.geolocated)
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.geojson do
        render json: GeojsonProfileDecorator.decorate(@profile)
      end
    end
  end

  def destroy
    if @profile.destroy
      expire_geojson @profile
    end

    respond_to do |format|
      format.html { redirect_to profiles_path, notice: I18n.t('profiles.destroy.success') }
    end
  end

  protected

  def setup_profiles
    @profiles =
      if params[:filter] == 'owned' && user_signed_in?
        current_user.profiles
      else
        # TODO Test Profile.accessible_by(current_ability)
        Profile.all
      end

    # Filter with query if present, or return a default order.
    # TODO Let the user request a specific ordering.
    @profiles =
      if params[:q].present?
        @profiles.ransack(params[:q]).result(distinct: true)
      else
        @profiles.order(date: :desc)
      end
  end
end
