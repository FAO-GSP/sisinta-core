# Transforms WoSIS CSV data into the format understood by SiSINTA.

module Etl
  module Wosis
    class FormatToSisintaProfiles
      def process(row)
        row[:country_code] = Etl::Wosis.iso_alpha3(iso_alpha2: row.delete(:country_id).last)
        row[:profile_identifier] = row.delete(:profile_id).last
        # row[:order] = row.delete( ? )

        row
      end
    end
  end
end
