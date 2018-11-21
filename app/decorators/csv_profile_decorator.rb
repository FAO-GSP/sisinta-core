# Creates CSV-like rows from a Profile, ready to be serialized.

class CsvProfileDecorator < ProfileDecorator
  decorates :profile
  decorates_association :layers, scope: :from_top_to_bottom, with: CsvLayerDecorator

  # Use this class for collection decoration.
  def self.collection_decorator_class
    CsvDecorator
  end

  # Returns row objects with this Profile data, for each layer or a single row if empty.
  def rows(filter: {}, extra: {})
    profile_attributes = serializable_hash(filter: filter[:profile], extra: extra)

    # Build an empty row to, at least, export the Profile attributes.
    decorated_layers = layers.any? ? layers : [CsvLayerDecorator.decorate(object.layers.build)]

    decorated_layers.collect do |layer|
      layer.row(filter: filter[:layer], extra: profile_attributes)
    end
  end

  # Filters profile attributes and/or adds extra to the profile.
  def serializable_hash(filter: nil, extra: {})
    super(filter || CsvProfileDecorator.exportable_attributes).merge extra
  end

  # Serializes the Profile identifier or a default one if missing.
  def profile_identifier
    identifier
  end

  # Serializes the License acronym.
  def license
    object.license.try :acronym
  end

  # Serializes the ProfileType value.
  def type
    object.type.try :value
  end

  def self.exportable_attributes
    {
      only: [
        :country_code,
        :date,
        :order,
        :source,
        :contact
      ],
      methods: [
        :profile_identifier,
        :type,
        :license,
        :latitude,
        :longitude
      ]
    }
  end
end
