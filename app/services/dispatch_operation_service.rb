# Creates and dispatches an Operation by name.

class DispatchOperationService < ApplicationService
  include ActiveModel::Model

  attr_accessor :user, :name

  def call
    @operation = user.operations.create(
      name: operation_name,
      profile_ids: user.current_selection
    )

    operation_job.perform_later @operation
    
    @operation
  end

  # Sanitizes user provided Operation name.
  def operation_name
    case name
    when 'csv_export'
      # i18n-tasks-use t('operations.create.csv_export')
      I18n.t(name, scope: 'operations.create')
    else
      I18n.t('no_operation', scope: 'operations.create', name: name)
    end
  end

  # Maps operation name with class.
  def operation_job 
    case name
    when 'csv_export'
      ExportCsvJob
    else
      NoOperationJob
    end
  end
end
