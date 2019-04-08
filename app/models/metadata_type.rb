# A MetadataType is a possible value for a specific field name used for input
# in the system. Most likely corresponds to a persisted field in an existing
# model but it could be virtual.
class MetadataType < ApplicationRecord
  # Currently only allow metadata on the these fields.
  FIELD_NAMES = %w{
    order
    bulk_density
    ca_co3
    coarse_fragments
    ecec
    conductivity
    organic_carbon
    ph
    clay
    silt
    sand
  }

  extend Mobility
  translates :value

  validates :field_name, presence: true, inclusion: { in: FIELD_NAMES }
  validates :value, presence: true, uniqueness: { scope: :field_name }
end
