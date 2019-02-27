# GeoJSON Profiles cache generation
module GeojsonCache
  extend ActiveSupport::Concern

  included do
    # Only ProfilesController exports GeoJSON, but other controllers could bust the cache.
    if self == ProfilesController
      caches_page :index, :show, gzip: :best_compression, if: :geojson_request?
    end
  end

  def geojson_request?
    request.format.geojson?
  end

  # Every time a Profile or its relationships are modified (updated, created,
  # destroyed) it is needed to bust the index and that specific cached profile.
  #
  # Expiration `target` can be a single profile, none, or a collection.
  def expire_geojson(target = nil, **job_options)
    if target.respond_to?(:each)
      target.each { |profile| expire_profile_geojson(profile) }
    elsif target.present?
      expire_profile_geojson target
    end

    expire_profiles_geojson job_options
  end

  # Expire a single profile in every locale.
  def expire_profile_geojson(profile = nil)
    I18n.available_locales.each do |locale|
      expire_page base_params.merge(action: :show, locale: locale, id: profile) if profile.present?
    end
  end

  # Expire profiles indices in every locale and regenerate them.
  def expire_profiles_geojson(job_options = {})
    I18n.available_locales.each do |locale|
      page_params = base_params.merge(action: :index, locale: locale)

      expire_page page_params
      WarmCacheJob.set(job_options).perform_later url_for(page_params)
    end
  end

  private

  # Common params in every geojson request
  def base_params
    { controller: :profiles, format: :geojson }
  end
end
