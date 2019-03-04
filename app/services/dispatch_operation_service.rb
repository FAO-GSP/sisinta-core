# Creates and dispatches an Operation by name.

class DispatchOperationService < ApplicationService
  include ActiveModel::Model

  attr_accessor :user, :name, :process

  def call
    @operation = user.operations.create(
      name: operation_name,
      profile_ids: user.current_selection,
      pure: operation_purity,
      process: process
    )

    @operation.enqueue!
    operation_job.perform_later @operation
    
    @operation
  end

  # Sanitizes user provided Operation name.
  def operation_name
    case name
    when 'export', 'process_with_r', 'delete'
      # i18n-tasks-use t('operations.index.export')
      # i18n-tasks-use t('operations.index.process_with_r')
      # i18n-tasks-use t('operations.index.delete')
      I18n.t("#{name}.title", scope: 'operations.index', process: process)
    else
      I18n.t('no_operation', scope: 'operations.create', name: name)
    end
  end

  # Maps operation name with class.
  def operation_job 
    case name
    when 'export'
      ExportJob
    when 'process_with_r'
      ProcessWithRJob
    when 'delete'
      DeleteProfilesJob
    else
      NoOperationJob
    end
  end

  # Operations can be pure (without side effects) or not, thus needing cache
  # busting, for example.
  def operation_purity
    case name
    when 'delete'
      false
    else
      true
    end
  end
end
