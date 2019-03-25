# A MetadataType is a possible value for a specific field name used for input
# in the system. Most likely corresponds to a persisted field in an existing
# model but it could be virtual.
class MetadataType < ApplicationRecord
  validates :field_name, presence: true
  validates :value, presence: true, uniqueness: { scope: :field_name }
end
