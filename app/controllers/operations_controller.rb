# Manage long running operations.

class OperationsController < ApplicationController
  # FIXME Define cancancan abilities, maybe read current user?
  load_and_authorize_resource through: :current_user

  decorates_assigned :operation, :operations

  def index
    # Show latest operations first
    @operations = @operations.latest
  end

  def show
  end

  def create
    # TODO Test Profile.where(id: current_user.current_selection)
    authorize! :read, Profile

    @operation = DispatchOperationService.call operation_params.merge(user: current_user)

    respond_to do |format|
      format.html { redirect_to operation_path(@operation), notice: I18n.t('operations.create.processing') }
    end
  end

  private

  def operation_params
    params.require(:operation).permit(:name)
  end
end
