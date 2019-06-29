# Operation presentation methods.

class OperationDecorator < ApplicationDecorator
  # i18n-tasks-use t('activerecord.attributes.operation.new')
  # i18n-tasks-use t('activerecord.attributes.operation.queued')
  # i18n-tasks-use t('activerecord.attributes.operation.running')
  # i18n-tasks-use t('activerecord.attributes.operation.completed')
  # i18n-tasks-use t('activerecord.attributes.operation.failed')
  def state
    Operation.human_attribute_name(object.state)
  end

  def download_link
    if object.completed? && results.attached?
      h.link_to results.filename, h.rails_blob_path(results), download: file_name, target: :_blank
    end
  end

  def start_time
    h.l object.created_at, format: :short
  end

  def file_name
    object.results.try :original_filename
  end
end
