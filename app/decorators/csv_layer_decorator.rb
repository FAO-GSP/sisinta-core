# Creates a CSV-like row from a Layer, ready to be serialized.

class CsvLayerDecorator < LayerDecorator
  decorates :layer

  # Returns a row object created from the layer information.
  def row(filter: nil, extra: {})
    attributes = serializable_hash(filter: filter, extra: extra)

    CSV::Row.new attributes.keys, attributes.values
  end

  # Filters layer attributes and/or adds extra, i.e. profile attributes, to
  # the layer.
  def serializable_hash(filter: nil, extra: {})
    super(filter || CsvLayerDecorator.exportable_attributes).merge extra
  end

  # Distinguish from profile identifier.
  def layer_identifier
    identifier
  end

  # Default attributes to export as csv when no filter is provided.
  def self.exportable_attributes
    {
      only: [
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
