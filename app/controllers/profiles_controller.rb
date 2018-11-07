class ProfilesController < ApplicationController
  include GeojsonCache

  decorates_assigned :profile, :profiles

  def index
    # Filter with query if present, or return a default order.
    # TODO Let the user request a specific ordering.
    @profiles =
      if params[:q].present?
        Profile.search(params[:q]).result(distinct: true)
      else
        Profile.order(date: :desc)
      end

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
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html
      format.geojson do
        render json: GeojsonDecorator.decorate(@profile)
      end
    end
  end
end
