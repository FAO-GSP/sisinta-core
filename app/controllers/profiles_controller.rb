class ProfilesController < ApplicationController
  include GeojsonCache

  decorates_assigned :profile, :profiles

  def index
    respond_to do |format|
      format.html do
        # Return paginated and decorated objects to view.
        @profiles = Profile.order(date: :desc).page(params[:page]).per(params[:page_size])
      end

      format.geojson do
        # Return every Profile with coordinates.
        render json: GeojsonCollectionDecorator.decorate(Profile.geolocated)
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
