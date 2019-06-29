# Creates a GeoJSON compatible representation of a Layer.

class GeojsonLayerDecorator < LayerDecorator
  decorates :layer

  # Filters layer attributes and/or adds extra, i.e. profile attributes, to
  # the layer.
  # TODO Reduce duplication with CsvLayerDecorator.
  def serializable_hash(options = nil)
    super GeojsonLayerDecorator.exportable_attributes
  end

  # Distinguish from profile identifier.
  # TODO Reduce duplication with CsvLayerDecorator.
  def layer_identifier
    identifier
  end

  # Default attributes to export as csv when no filter is provided.
  # TODO Reduce duplication with CsvLayerDecorator.
  def self.exportable_attributes
    {
      only: [
        :profile_id,
        :top,
        :bottom,
        :designation,
        :bulk_density,
        :ca_co3,
        :coarse_fragments,
        :ecec,
        :conductivity,
        :organic_carbon,
        :ph,
        :clay,
        :silt,
        :sand,
        :water_retention
      ],
      methods: :layer_identifier
    }
  end
end
