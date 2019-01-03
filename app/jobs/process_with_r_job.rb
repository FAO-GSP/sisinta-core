# Calls the R API for processing selected profiles.

class ProcessWithRJob < ApplicationJob
  def perform(operation)
    open(api_endpoint(process: operation.process)) do |file|
      filename = [
        operation.process,
        Time.zone.now.to_s(:number),
        file.content_type.split('/').last
      ].join('.')

      operation.results.attach(
        io: file,
        filename: filename,
        content_type: file.content_type
      )
      operation.update finished: true
    end
  rescue OpenURI::HTTPError
    # TODO Prefer `failed` state
    operation.update finished: true
  end

  def api_endpoint(process: '')
    [
      Rails.configuration.x['rapi']['base_path'],
      process
    ].join('/')
  end
end
