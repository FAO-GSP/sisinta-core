# Profile presentation methods.

class ProfileDecorator < ApplicationDecorator
  decorates_association :location
  decorates_association :user
  decorates_association :license
  decorates_association :type
  decorates_association :layers, scope: :from_top_to_bottom

  delegate :coordinates, :coordinates_array, to: :location
  delegate :name, to: :user, prefix: true
  delegate :link, :statement, to: :license, prefix: true

  # Localized date.
  def date
    h.l(object.date) if object.date.present?
  end

  # Link to self.
  def link
    h.link_to identifier, object
  end

  # Identifier with fallback.
  # i18n-tasks-use t('activerecord.models.profile').
  def identifier
    object.identifier.present? ? object.identifier : last_resort_identifier
  end

  # Looks up the country name by ISO3166 code.
  def country
    h.country_from_code(object.country_code).name
  end

  # Always provide some kind of contact information.
  def contact
    object.contact || user.email
  end

  # How to display this model in ActiveAdmin.
  def display_name
    identifier
  end
end
