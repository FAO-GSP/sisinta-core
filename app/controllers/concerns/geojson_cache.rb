# GeoJSON Profiles cache generation
module GeojsonCache
  extend ActiveSupport::Concern

  included do
    # Only ProfilesController exports GeoJSON, but other controllers could bust the cache
    if self == ProfilesController
      caches_page :index, :show, gzip: :best_compression, if: :geojson_request?
    end
  end

  def geojson_request?
    request.format.geojson?
  end
end
