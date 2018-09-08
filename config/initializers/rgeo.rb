# rgeo and related gems configuration

RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
  # Use a geographic factory by default. This factory actually uses 2
  # coordinate systems. First one is EPSG:4326 (http://spatialreference.org/ref/epsg/4326).
  # The second coordinate system (http://spatialreference.org/ref/sr-org/6864)
  # is called EPSG:3857 and is used in a projected factory to produce data
  # compatible with web mapping systems.
  #
  # Latitudes are restricted to the range (-85.0511287, 85.0511287),
  # which results in a square projected domain.
  config.default = RGeo::Geographic.simple_mercator_factory
end
