# Profile presentation methods
class ProfileDecorator < ApplicationDecorator
  decorates_association :location
  decorates_association :user
  decorates_association :license

  delegate :coordinates, to: :location
  delegate :name, to: :user, prefix: true
  delegate :link, :statement, to: :license, prefix: true

  # Localized date
  def date
    h.l(object.date) if object.date.present?
  end

  # Link to self
  def link
    h.link_to identifier, object
  end

  # Identifier with fallback
  # i18n-tasks-use t('activerecord.models.profile') 
  def identifier
    object.identifier.present? ? object.identifier : last_resort_identifier
  end

  # Looks up the country name by ISO3166 code
  def country
    ISO3166::Country.find_country_by_alpha3(object.country_code).name
  end

  # Always provide some kind of contact information
  def contact
    object.contact || user.email
  end
end
