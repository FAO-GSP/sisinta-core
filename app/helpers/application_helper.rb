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
    image_tag "#{Rails.configuration.x['core_engine']}/app.svg", alt: app_name
  end

  # Each page that wants a title should provide it
  def page_title
    content_for :page_title
  end
end
