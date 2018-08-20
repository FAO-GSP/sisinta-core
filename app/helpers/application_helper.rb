# Base helper

module ApplicationHelper
  def app_name
    Rails.configuration.x['brand']['name']
  end

  def app_url
    Rails.configuration.x['brand']['url']
  end

  def contact_email
    Rails.configuration.x['brand']['contact']
  end

  def brand_tag
    # brand_logo must be defined on the customization engine
    image_tag brand_logo, alt: app_name
  end

  # Reverse title and app order for useful tab names in browsers
  def application_title
    [page_title, app_name].reject(&:nil?).join(' | ')
  end

  # Each page that wants a title should provide it
  def page_title
    content_for :page_title
  end
end
