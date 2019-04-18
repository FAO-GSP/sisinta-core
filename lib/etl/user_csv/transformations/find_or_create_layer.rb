# Finds or creates a Layer associated with a Profile, uniquely identified by
# its layer_identifier or a combination of its bounds (top and bottom).

module Etl
  module UserCsv
    class FindOrCreateLayer
      # Each row comes with a `system_profile_id` which we added while creating
      # the Profile earlier.
      def process(row)
        # Load the Profile.
        profile = Profile.find row[:system_profile_id]

        # Load the Layer
        layer = profile.layers.find_or_initialize_by identifier(row)

        layer.top = row[:top]
        layer.bottom = row[:bottom]
        layer.designation = row[:designation]

        layer.bulk_density = row[:bulk_density]
        layer.ca_co3 = row[:ca_co3]
        layer.coarse_fragments = row[:coarse_fragments]
        layer.ecec = row[:ecec]
        layer.conductivity = row[:conductivity]
        layer.organic_carbon = row[:organic_carbon]
        layer.ph = row[:ph]
        layer.clay = row[:clay]
        layer.silt = row[:silt]
        layer.sand = row[:sand]
        layer.water_retention = row[:water_retention]

        layer.save!
        profile.save!

        row
      rescue ActiveRecord::RecordInvalid => e
        ap row

        raise CsvImportError.new e.message, row
      end

      # A unique (probably) identifier for this layer.
      def identifier(row)
        if row[:layer_identifier].present?
          { identifier: row[:layer_identifier] }
        else
          { identifier: [row[:top], row[:bottom]].join }
        end
      end
    end
  end
end
