# Namespaced exports
Map = {}
Sisinta.map = Map

# Bind a popup box for each feature.
Map.prepare_popup = (feature, layer) ->
  layer.bindPopup Map.popup_markup(feature.properties)

# Generate the markup for each popup.
# TODO Add source to the identifier
Map.popup_markup = (feature) ->
  [
    "<a target='_blank' title='feature' href='#{feature.url}'>",
      feature.identifier,
    '</a>'
  ].join('')

# Generate a colored circle marker for each feature.
Map.prepare_marker = (point, latlng) ->
  # https://clrs.cc
  accessible = '#0d6cac'
  restricted = '#f58231'

  style =
    radius: 5
    weight: 1
    fillOpacity: 0.7
    fillColor: if point.properties.public then accessible else restricted
    color: '#000000'

  return L.circleMarker(latlng, style)

# Filter features by visibility.
Map.filters =
  public_features: (feature, layer) ->
    return feature.properties.public
  private_features: (feature, layer) ->
    return !feature.properties.public
