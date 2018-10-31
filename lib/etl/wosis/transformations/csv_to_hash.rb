# Just transform a csv row to hash for further processing.

module Etl
  module Wosis
    class CsvToHash
      def process(row)
        row.to_hash
      end
    end
  end
end
