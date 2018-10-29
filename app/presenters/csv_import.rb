# Simple view object for ImportsController.

class CsvImport
  include ActiveModel::Model

  attr_accessor :file, :user, :type_id, :license_id, :source, :contact, :country_code

  # List of allowed CSV headers for importing
  # TODO Extract to UI gems (pass it as attribute to .template method)
  def self.headers
    %w{
      profile_identifier
      layer_identifier
      latitude
      longitude
      country_code
      top
      bottom
      date
      type
      order
      source
      contact
      license
      designation
      bulk_density
      ca_co3
      coarse_fragments
      ecec
      conductivity
      organic_carbon
      ph_h2o_1
      ph_h2o_2_5
      ph_kcl_1
      ph_kcl_2_5
      clay
      silt
      sand
      water_retention
    }
  end

  def self.template
    CSV.generate headers: true, force_quotes: true do |csv|
      csv << self.headers
    end
  end
end
