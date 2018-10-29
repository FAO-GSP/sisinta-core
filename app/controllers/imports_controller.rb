# Handles everything associated with bulk imports of data, usually through CSV
class ImportsController < ApplicationController
  include GeojsonCache

  skip_authorization_check only: [:new, :template]

  # Landing with explanation of the process and form to post
  def new
    @import = CsvImport.new license_id: License.default.to_param
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

  # Uploads a CSV file with layer information
  def create
    authorize! :create, Profile

    import = CsvImport.new import_params.merge({ user: current_user })

    if CsvImportService.call(import: import)
      expire_geojson

      # FIXME i18n
      flash[:notice] = 'Perfiles importados correctamente'
    else
      flash[:alert] = import.errors.full_messages.to_sentence
    end

    respond_to do |format|
      format.html do
        redirect_to new_import_path
      end
    end
  end

  private

  def import_params
    params.require(:import).permit(
      :file, :type_id, :license_id, :source, :contact, :country_code
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
