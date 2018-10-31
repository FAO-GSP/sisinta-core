# Select rows to process based on it's ISO code.

module Etl
  module Wosis
    class FilterByCountry
      attr_reader :iso_codes

      def initialize(iso_codes:)
        @iso_codes = iso_codes
      end

      def process(row)
        iso_alpha3 = Etl::Wosis.iso_alpha3(iso_alpha2: row[:country_id])

        # Discard rows from countries that aren't specified.
        iso_codes.include?(iso_alpha3) ? row : nil
      end
    end
  end
end
