# SisinaMap exports. See
# https://robots.thoughtbot.com/module-pattern-in-javascript-and-coffeescript
window.SisintaMap = {}

# Bind a popup box for each feature.
SisintaMap.prepare_popup = (feature, layer) ->
  layer.bindPopup SisintaMap.popup_markup(feature.properties)

# Generate the markup for each popup.
SisintaMap.popup_markup = (feature) ->
  [
    "<a target='_blank' title='feature' href='#{feature.url}'>",
      feature.identifier,
    '</a>'
  ].join('')

# Generate a colored circle marker for each feature.
SisintaMap.prepare_marker = (point, latlng) ->
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
SisintaMap.filters =
  public_features: (feature, layer) ->
    return feature.properties.public
  private_features: (feature, layer) ->
    return !feature.properties.public
