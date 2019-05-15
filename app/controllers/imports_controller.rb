# Handles everything associated with bulk imports of data, usually through CSV.

class ImportsController < ApplicationController
  include GeojsonCache

  # Always expire because of partial imports.
  after_action :expire_geojson, only: [:create]

  # Landing with explanation of the process and form to post.
  def new
    # Prepare defaults.
    # TODO Associate metadata defaults with the user somehow.
    @import = CsvImport.new license_id: License.default.to_param,
      type_id: ProfileType.default.to_param, metadata: []
  end

  # Downloads the template with keyed columns
  def template
    respond_to do |format|
      format.csv do
        send_data CsvImport.template,
          filename: template_file_name,
          type: 'text/csv',
          disposition: 'inline'
      end
    end
  end

  # Uploads a CSV file with layer information.
  def create
    authorize! :create, Profile

    @import = CsvImport.new import_params.merge({ user: current_user })

    respond_to do |format|
      if CsvImportService.call(import: @import)
        # Normally redirects to #show for the newly created model.
        format.html { redirect_to new_import_path, notice: I18n.t('imports.create.success') }
      else
        format.html do
          render action: :new
        end
      end
    end
  end

  private

  def import_params
    params.require(:import).permit(
      :file, :type_id, :license_id, :source, :contact, :country_code,
      metadata: []
    )
  end

  # Generates an internationalized name for the CSV template file.
  def template_file_name
    [
      I18n.t('imports.new.template'),
      '_',
      Profile.model_name.human(count: 2),
      '.csv'
    ].join.downcase
  end
end
