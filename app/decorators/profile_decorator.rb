# Profile presentation methods
class ProfileDecorator < ApplicationDecorator
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
end
