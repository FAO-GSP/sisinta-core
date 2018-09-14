# License presentation methods
class LicenseDecorator < ApplicationDecorator
  def full_name
    "#{object.name} (#{object.acronym})"
  end

  # Link to the license url which opens in a new page/tab
  def link
    h.link_to full_name, url, target: '_blank'
  end

  # A declaration of attribution which includes html, links, provided by the
  # license authors.
  def statement
    h.raw object.statement
  end
end
