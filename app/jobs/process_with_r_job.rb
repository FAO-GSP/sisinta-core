# Calls the R API for processing selected profiles.

class ProcessWithRJob < ApplicationJob
  attr_accessor :operation, :response

  def perform(operation)
    self.operation = operation

    profiles = Profile.where(id: operation.profile_ids)

    json = GeojsonCollectionDecorator.new(profiles).to_json

    self.response = Rapi.new(json).process(operation.process)

    if response.success?
      Tempfile.open(filename) do |file|
        file.binmode
        file.write(response.body)
        file.rewind

        operation.results.attach(
          io: file,
          filename: filename,
          content_type: response.content_type
        )
        operation.update finished: true
      end
    else
      # TODO Prefer `failed` state
      operation.update finished: true, error_message: I18n.t(response.code, scope: 'rapi.response.code')
    end
  rescue HTTParty::Error => e
    operation.update finished: true, error_message: e.message
  end

  # Generates a filename for the operaton results.
  def filename
    return unless response.present?

    @filename ||= [
      operation.process,
      Time.zone.now.to_s(:number),
      response.content_type.split('/').last
    ].join('.')
  end
end
