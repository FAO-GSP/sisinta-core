require 'etl/wosis'

namespace :etl do
  namespace :wosis do
    desc 'Parse WoSIS CSV and load Profiles through SiSINTA models'
    task import_profiles: :environment do
      file = ENV['WOSIS_PROFILES_FILE']
      email = ENV['WOSIS_USER_EMAIL']

      raise ArgumentError.new('Missing WOSIS_PROFILES_FILE param') if file.blank?
      raise ArgumentError.new('Missing WOSIS_USER_EMAIL param') if email.blank?
      raise ArgumentError.new("#{file} is not a file") unless File.file?(file)

      Etl::Wosis.import_profiles!(
        file: file,
        profile_attributes: { user: User.find_by!(email: email) }
      )
    rescue ArgumentError => e
      Rails.logger.error e.message
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error e.message
    end

    desc 'Parse WoSIS CSV and load Layers through SiSINTA models'
    task import_layers: :environment do
      file = ENV['WOSIS_LAYERS_FILE']

      raise ArgumentError.new('Missing WOSIS_LAYERS_FILE param') if file.blank?

      Etl::Wosis.import_layers! file: file
    rescue ArgumentError => e
      Rails.logger.error e.message
    end

    desc 'Parse WoSIS CSV and select specific profiles, discarding the rest'
    task select_profiles: :environment do
      source = ENV['SOURCE_WOSIS_PROFILES_FILE']
      destination = ENV['WOSIS_PROFILES_FILE']

      raise ArgumentError.new('Missing SOURCE_WOSIS_PROFILES_FILE param') if file.blank?
      raise ArgumentError.new('Missing WOSIS_PROFILES_FILE param') if file.blank?

      Etl::Wosis.select_profiles! source: source, destination: destination
    rescue ArgumentError => e
      Rails.logger.error e.message
    end

    desc 'Parse WoSIS CSV and select specific layers, discarding the rest'
    task select_layers: :environment do
      source = ENV['SOURCE_WOSIS_LAYERS_FILE']
      destination = ENV['WOSIS_LAYERS_FILE']

      raise ArgumentError.new('Missing SOURCE_WOSIS_LAYERS_FILE param') if file.blank?
      raise ArgumentError.new('Missing WOSIS_LAYERS_FILE param') if file.blank?

      Etl::Wosis.select_layers! source: source, destination: destination
    rescue ArgumentError => e
      Rails.logger.error e.message
    end
  end
end
