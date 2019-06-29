class ProfilesController < ApplicationController
  include GeojsonCache

  before_action :setup_profiles, only: :index
  load_and_authorize_resource

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
      # FIXME, Tests sometimes failing?
      # FIXME, bin/rails test test/system/profile_test.rb:34
      format.html { redirect_to profiles_path, notice: I18n.t('profiles.destroy.success') }
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: I18n.t('profiles.update.success') }
      else
        format.html { render :edit }
      end
    end
  end

  def new
    @profile = current_user.profiles.build
  end

  def create
    @profile.assign_attributes user: current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: I18n.t('profiles.create.success') }
      else
        format.html { render :new }
      end
    end
  end

  protected

  def profile_params
    params.require(:profile).permit(
      :identifier, :type_id, :date, :country_code, :order, :source, :contact,
      :license_id, :public
    )
  end

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
