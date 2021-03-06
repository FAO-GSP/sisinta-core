# Finds or creates a Profile uniquely identified with a combination of columns
# and updates it.

module Etl
  module UserCsv
    class FindOrCreateProfile
      attr_accessor :attributes

      def initialize(attributes)
        @attributes = attributes
      end

      def process(row)
        profile = Profile.find_or_initialize_by uuid: uuid_from(row)

        # Assign global data.
        profile.assign_attributes attributes

        # Overwrites global data.
        profile.source = row[:source] if row[:source].present?
        profile.contact = row[:contact] if row[:contact].present?
        # TODO Normalize country codes with https://github.com/wbotelhos/normalizy
        profile.country_code = row[:country_code].upcase if row[:country_code].present?

        # Overwrites ProfileType if its valid.
        if row[:type].present?
          type_from_csv = ProfileType.i18n.find_by(value: row[:type])
          profile.type = type_from_csv || ProfileType.find(attributes[:type_id])
        end

        # Overwrites License if its valid.
        if row[:license].present?
          license_from_csv = License.find_by(acronym: row[:license])
          profile.license = license_from_csv || License.find(attributes[:license_id])
        end

        # Can be nil.
        profile.identifier = row[:profile_identifier]
        profile.date = row[:date]
        profile.order = row[:order]

        # Location is never changed from an existing one because it would change the UUID.
        unless profile.coordinates.present?
          coordinates = Location.generate_coordinates(latitude: row[:latitude], longitude: row[:longitude])
          profile.build_location(coordinates: coordinates)
        end

        profile.save!

        # Preserve the generated Profile id within data row for further
        # processing.
        row[:system_profile_id] = profile.to_param

        row
      rescue ActiveRecord::RecordInvalid => e
        ap row

        raise CsvImportError.new e.message, row
      end

      # Gets the UUID for this Profile.
      def uuid_from(row)
        Profile.generate_uuid(
          country_code: (row[:country_code] || attributes[:country_code]),
          source: (row[:source] || attributes[:source]),
          identifier: row[:profile_identifier],
          longitude: row[:longitude],
          latitude: row[:latitude]
        )
      end
    end
  end
end
