# Generates a CSV with selected profiles and attaches the result to the
# Operation.

class ExportJob < ApplicationJob
  def perform(operation)
    profiles = Profile.where(id: operation.profile_ids)
    file = Tempfile.new([base_file_name, '.csv'])
    headers = CsvDecorator.default_headers

    # Write headers.
    csv_options = {
      headers: headers,
      write_headers: true
    }

    # Open the file only once.
    CSV.open(file.path, 'w', csv_options) do |file|
      # Iterate and write in batches.
      profiles.in_batches do |batch|
        CsvDecorator.new(batch).rows do |row|
          # TODO Verify this map is needed.
          file << headers.map { |key| row[key] }
        end
      end
    end

    operation.results.attach(
      io: file,
      filename: "#{base_file_name}.csv",
      content_type: 'text/csv'
    )
    operation.update finished: true

    file.close
    file.unlink
  end

  def base_file_name
    [
      Profile.model_name.human(count: 2),
      Time.zone.now.to_s(:short)
    ].join('_').parameterize
  end
end
