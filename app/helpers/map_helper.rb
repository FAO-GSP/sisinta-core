# Maps related helpers

module MapHelper
  # The current API URL with client's key
  def self.google_maps_api_url
    [
      'http://maps.google.com/maps/api/js?v=3&libraries=geometry&key=',
      Rails.configuration.x['google_api_key']
    ].join.html_safe
  end

  # For inserting only in pages with maps
  def google_maps_js_tag
    javascript_include_tag MapHelper.google_maps_api_url,
      # Don't reload Google Maps API when visiting with turbolinks
      data: { turbolinks_eval: false }
  end
end
