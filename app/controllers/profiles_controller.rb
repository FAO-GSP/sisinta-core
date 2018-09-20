class ProfilesController < ApplicationController
  def index
    # Basic pagination.
    @profiles = Profile.order(date: :desc).page(params[:page]).per(params[:page_size])

    respond_to do |format|
      format.html do
        # Return decorated objects to view.
        @profiles = @profiles.decorate
      end

      format.geojson do
        # FIXME Don't hardcode
        hardcode = '{"type":"FeatureCollection",
        "features":[{"type":"Feature",
          "geometry":{"type":"Point","coordinates":[-68.85,-46.4]},"properties":{"id":1,"identifier":"605/25","date":"14/02/1959","order":"","url":"http://localhost:3000/es/profiles/1"}}]}'

        render json: hardcode
      end
    end
  end

  def show
    @profile = Profile.find(params[:id]).decorate
  end
end
