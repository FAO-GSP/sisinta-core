# Handles everything associated with bulk imports of data, usually through CSV.

class ImportsController < ApplicationController
  include GeojsonCache

  # Landing with explanation of the process and form to post.
  def new
    # Prepare defaults.
    @import = CsvImport.new license_id: License.default.to_param,
      type_id: ProfileType.default.to_param
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
        expire_geojson

        # Normally redirects to #show for the newly created model.
        format.html { redirect_to new_import_path, notice: I18n.t('.success') }
      else
        format.html do
          # Prefer to specify the error as flash instead of picking it from the
          # model in the view.
          flash[:alert] = @import.errors.full_messages.to_sentence
          render action: :new
        end
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
