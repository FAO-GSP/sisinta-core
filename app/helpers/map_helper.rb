# Maps related helpers

module MapHelper
  # For inserting only in pages with maps
  def google_maps_js_tag
    javascript_include_tag google_maps_api_url
  end

  # The current API URL with client's key
  def google_maps_api_url
    [
      'http://maps.google.com/maps/api/js?v=3&libraries=geometry&key=',
      Rails.configuration.x['google_api_key']
    ].join.html_safe
  end
end
