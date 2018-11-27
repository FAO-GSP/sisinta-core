class OperationDecorator < ApplicationDecorator
  # i18n-tasks-use t('activerecord.attributes.operation.complete')
  # i18n-tasks-use t('activerecord.attributes.operation.pending')
  def state
    if object.finished?
      Operation.human_attribute_name(:complete)
    else
      Operation.human_attribute_name(:pending)
    end
  end

  def download_link
    if object.finished? && results.attached?
      h.link_to results.filename, h.rails_blob_path(results), download: file_name
    end
  end

  def start_time
    h.l object.created_at, format: :short
  end

  def file_name
    object.results.try :original_filename
  end
end
