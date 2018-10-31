# Parse WoSIS database from the official CSV snapshot.

require 'countries'
require 'etl/wosis/transformations/filter_by_country'
require 'etl/wosis/transformations/format_to_sisinta_profiles'
require 'etl/user_csv/transformations/find_or_create_profile'

module Etl
  module Wosis
    def self.import_profiles!(file:, profile_attributes: {})
      job = Kiba.parse do
        source Kiba::Common::Sources::CSV, filename: file,
          csv_options: Etl::Wosis.default_csv_options

        transform FilterByCountry,
          iso_codes: Rails.configuration.engine.default_country_codes
        transform FormatToSisintaProfiles
        transform Etl::UserCsv::FindOrCreateProfile,
          Etl::Wosis.default_attributes.merge(profile_attributes)
      end

      Kiba.run(job)
    end

    def self.default_csv_options
      { headers: true, header_converters: :symbol, col_sep: "\t", encoding: 'utf-8' }
    end

    def self.default_attributes
      {
        source: 'WoSIS July 2016 Snapshot',
        contact: 'niels.batjes@wur.nl'
      }
    end

    # Returns ISO 3166-1 alpha-3 from ISO 3166-1 alpha-2
    def self.iso_alpha3(iso_alpha2:)
      case iso_alpha2
      # AN/ANT is deprecated, so it's not recognizable by 'countries' gem. We have
      # to treat it as an exception until we develop something for obsolete data.
      #
      # See https://github.com/FAO-GSP/SISLAC/issues/3
      when 'AN'
        'ANT'
      else
        # Search country by alpha2 code.
        country = ISO3166::Country.new iso_alpha2

        # Returns nil if none found.
        country && country.alpha3
      end
    end
  end
end
