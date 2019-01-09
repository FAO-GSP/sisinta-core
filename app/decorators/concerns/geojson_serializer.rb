# Helper methods for GeoJSON serialization, included by decorators.
module GeojsonSerializer
  # Use profile_url directly without ViewContext.
  include Rails.application.routes.url_helpers

  # Call UrlHelpers without requests.
  def default_url_options
    Rails.application.config.action_mailer.default_url_options.merge locale: I18n.locale
  end

  # Primary generator method, called by ProfilesController each request.
  # TODO Pass options for properties inclusion (e.g. layers)
  def as_json(*_args)
    RGeo::GeoJSON.encode factory.feature_collection(features)
  end

  # Accessor for the default RGeo::GeoJSON feature/s factory.
  def factory
    RGeo::GeoJSON::EntityFactory.instance
  end
end
