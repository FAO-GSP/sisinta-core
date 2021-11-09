# Parse WoSIS database from the official CSV snapshot.

require 'countries'
require 'kiba-common/destinations/csv'
require 'etl/wosis/transformations/csv_to_hash'
require 'etl/wosis/transformations/filter_by_country'
require 'etl/wosis/transformations/filter_by_profile'
require 'etl/wosis/transformations/format_to_sisinta_profiles'
require 'etl/wosis/transformations/format_to_sisinta_layers'
require 'etl/user_csv/transformations/find_or_create_profile'
require 'etl/user_csv/transformations/find_or_create_layer'

module Etl
  module Wosis
    def self.select_profiles!(source:, destination:)
      job = Kiba.parse do
        source Kiba::Common::Sources::CSV, filename: source,
          csv_options: Etl::Wosis.source_csv_options

        transform FilterByCountry,
          iso_codes: Rails.configuration.engine.default_country_codes
        transform CsvToHash

        destination Kiba::Common::Destinations::CSV,
          filename: destination,
          csv_options: Etl::Wosis.destination_csv_options,
          headers: [
            :profile_id,
            :country_id,
            :latitude,
            :longitude
          ]
      end

      Kiba.run(job)
    end

    def self.select_layers!(source:, destination:)
      job = Kiba.parse do
        source Kiba::Common::Sources::CSV, filename: source,
          csv_options: Etl::Wosis.source_csv_options

        transform FilterByProfile, source: Etl::Wosis.default_attributes[:source]
        transform CsvToHash

        destination Kiba::Common::Destinations::CSV,
          filename: destination,
          csv_options: Etl::Wosis.destination_csv_options,
          headers: [
            :system_profile_id,
            :profile_layer_id,
            :top,
            :bottom,
            :bdws_value_avg,
            :tceq_value_avg,
            :cfvo_value_avg,
            :ecec_value_avg,
            :elco_value_avg,
            :orgc_value_avg,
            :phaq_value_avg,
            :phkc_value_avg,
            :clay_value_avg,
            :silt_value_avg,
            :sand_value_avg,
            :wrvo_value_avg
          ]
      end

      Kiba.run(job)
    end

    def self.import_profiles!(file:, profile_attributes: {})
      job = Kiba.parse do
        source Kiba::Common::Sources::CSV, filename: file,
          csv_options: Etl::Wosis.destination_csv_options

        transform FormatToSisintaProfiles
        transform Etl::UserCsv::FindOrCreateProfile,
          Etl::Wosis.default_attributes.merge(profile_attributes)
      end

      Kiba.run(job)
    end

    def self.import_layers!(file:)
      job = Kiba.parse do
        source Kiba::Common::Sources::CSV, filename: file,
          csv_options: Etl::Wosis.destination_csv_options

        transform FormatToSisintaLayers
        transform Etl::UserCsv::FindOrCreateLayer
      end

      Kiba.run(job)
    end

    # Options needed to read original WoSIS files, not the ones with filtered
    # data.
    def self.source_csv_options
      { headers: true, header_converters: :symbol, col_sep: "\t", encoding: 'utf-8' }
    end

    # Options needed to write and read trimmed WoSIS files.
    def self.destination_csv_options
      { headers: true, header_converters: :symbol, col_sep: ',', encoding: 'utf-8' }
    end

    # Default attributes for Profile creation.
    def self.default_attributes
      {
        source: 'WoSIS July 2016 Snapshot',
        contact: 'niels.batjes@wur.nl',
        license: License.find_by(acronym: 'CC-BY-NC-ND')
      }
    end

    # Returns ISO 3166-1 alpha-3 from ISO 3166-1 alpha-2.
    def self.iso_alpha3(iso_alpha2:)
      # Search country by alpha2 code.
      country = ISO3166::Country.new iso_alpha2

      # Returns nil if none found.
      country && country.alpha3
    end
  end
end
