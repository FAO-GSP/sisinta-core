# Validates and executes an import process based on a CSV file.
# TODO Validate csv format

require 'etl/user_csv'

class CsvImportService < ApplicationService
  include ActiveModel::Model

  attr_accessor :import, :error

  def call
    # We could capture the profile ids and redirect to a list/index of Profiles
    # from Import controller
    Etl::UserCsv::Job.new.import! import.file.path, profile_attributes

    true
  rescue CsvImportError => e
    import.errors.add :base, e.message

    false
  end

  private

  # Prepare attributes needed for Profile creation.
  def profile_attributes
    {
      user: import.user,
      type_id: import.type_id,
      license_id: import.license_id,
      source: import.source,
      contact: import.contact,
      country_code: import.country_code,
      metadata: import.metadata
    }
  end
end
