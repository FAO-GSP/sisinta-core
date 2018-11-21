# A collection of Profiles decorated with CsvProfileDecorator for
# serialization.

class CsvDecorator < Draper::CollectionDecorator
  # Use this class for item decoration.
  def decorator_class
    CsvProfileDecorator 
  end

  # Adds headers and serializes each member.
  def as_csv(filter: {}, extra: {}, write_headers: true)
    csv_options = {
      headers: CsvDecorator.default_headers,
      write_headers: write_headers,
      encoding: 'utf-8'
    }

    CSV.generate(csv_options) do |csv_string|
      rows(filter: filter, extra: extra) do |row|
        csv_string << row
      end
    end
  end

  # Decorates and accumulates rows and returns them, optionally passing them to
  # a block for extra processing.
  def rows(filter: {}, extra: {}, &block)
    processed_rows ||= []

    decorated_collection.each do |profile|
      profile.rows(filter: filter, extra: extra).each do |row|
        yield(row) if block_given?

        processed_rows << row
      end
    end

    processed_rows
  end

  def self.default_headers
    CsvImport.headers
  end
end
