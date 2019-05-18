# Manage long running operations.

class OperationsController < ApplicationController
  include GeojsonCache

  after_action :expire_geojson_if_needed, only: [:create]

  # FIXME Define cancancan abilities, maybe read current user?
  load_and_authorize_resource through: :current_user

  decorates_assigned :operation, :operations

  def index
    # Show latest operations first.
    @operations = @operations.latest
  end

  def show
  end

  def create
    # TODO Test Profile.where(id: current_user.clean_current_selection).
    authorize! :read, Profile

    @operation = DispatchOperationService.call operation_params.merge(user: current_user, process: params[:process])

    respond_to do |format|
      format.html { redirect_to operation_path(@operation), notice: I18n.t('operations.create.processing') }
    end
  end

  private

  def expire_geojson_if_needed
    # Crude heuristic, wait 2 seconds per profile
    estimated_operation_time = @operation.profile_ids.size.seconds * 2

    expire_geojson(wait: estimated_operation_time) unless @operation.pure?
  end

  def operation_params
    params.require(:operation).permit(:name, :process)
  end
end
