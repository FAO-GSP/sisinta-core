# Calls the R API for processing selected profiles.

class ProcessWithRJob < ApplicationJob
  attr_accessor :operation, :response, :profiles

  def perform(operation)
    operation.start!

    self.operation = operation
    self.profiles = Profile.where(id: operation.profile_ids)

    if profiles.empty?
      operation.fail
      operation.update error_message: I18n.t('jobs.process_with_r.no_profiles_selected')
    else
      # Call the API
      self.response = Rapi.new(
        GeojsonCollectionDecorator.new(profiles).to_json
      ).process(operation.process)

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
          operation.complete!
        end
      else
        # i18n-tasks-use t('rapi.response.code.404')
        # i18n-tasks-use t('rapi.response.code.500')
        operation.fail
        operation.update error_message: I18n.t(response.code, scope: 'rapi.response.code')
      end
    end
  # FIXME Raise Rapi::Error and catch this errors there
  rescue HTTParty::Error => e
    operation.fail
    operation.update error_message: e.message
  rescue Errno::ECONNREFUSED => e
    operation.fail
    operation.update error_message: I18n.t('rapi.unavailable')
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
