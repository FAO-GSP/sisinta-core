# Mime types for use in respond_to blocks.

# As GeoJson is a subtype of json and is generated with `to_json`, use an alias
Mime::Type.register_alias 'application/json', :geojson
