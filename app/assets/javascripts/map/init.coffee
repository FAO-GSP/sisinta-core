# Prepare Leaflet map on page load.

$(document).on 'turbolinks:load', ->
  map_container = $('#map')

  # If there is a map in this page.
  if map_container.length
    # Show the world by default but use configured values if present.
    zoom = map_container.data('zoom') || 2
    center = map_container.data('center') || [0, 0]

    map = L.map('map', {
      center: center
      zoom: zoom
      zoomControl: false
    })

    # Make the initialized map globally accessible
    Sisinta.map.instance = map

    # Configure tile layers.
    osm = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 18
      attribution: '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors (' +
        '<a href="http://opendatacommons.org/licenses/odbl/">ODbL</a>)'
    })

    g_terrain = L.gridLayer.googleMutant({ type: 'terrain' })
    g_hybrid = L.gridLayer.googleMutant({ type: 'hybrid' })

    tile_layers = {
      'OpenStreetMap': osm
      'Google': g_hybrid
      'Google Terrain': g_terrain
    }

    # Configure data layers.
    public_features = L.geoJson(null, {
      filter: Sisinta.map.filters.public_features
      pointToLayer: Sisinta.map.prepare_marker
      onEachFeature: Sisinta.map.prepare_popup
    })

    private_features = L.geoJson(null, {
      filter: Sisinta.map.filters.private_features
      pointToLayer: Sisinta.map.prepare_marker
      onEachFeature: Sisinta.map.prepare_popup
    })

    clusters = L.markerClusterGroup()
    data_layers = {}
    data_layers[map_container.data('profileLayerTitle')] = clusters

    # Initial layer.
    map.addLayer(g_hybrid)

    # Add zoom control.
    L.control.zoom({
      position: 'topright'
    }).addTo(map)

    # Add layer control.
    L.control.layers(tile_layers, data_layers).addTo(map)

    # Add info box.
    if map_container.data('infoTitle')
      L.control.info({
        title: map_container.data('infoTitle')
        text: map_container.data('infoText')
      }).addTo(map)

    # Retrieve our dataset and add it to the layer.
    $.getJSON map_container.data('geojson'), (data) ->
      public_features.addData(data)
      private_features.addData(data)

      clusters.addLayer(public_features)
      clusters.addLayer(private_features)
      clusters.addTo(map)
