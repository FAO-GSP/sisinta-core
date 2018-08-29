# Base helper.

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
    # brand_logo must be defined on the customization engine.
    image_tag brand_logo, alt: app_name
  end

  # Reverse title and app order for useful tab names in browsers.
  def application_title
    [page_title, app_name].reject(&:nil?).join(' | ')
  end

  # Each page that wants a title should provide it.
  def page_title
    content_for :page_title
  end

  # Profile attributes to query with global search
  def global_search_query
    :date_or_order_cont
  end

  # Creates a link which switches to a specific locale
  def link_to_locale(locale)
    # url_for reuses current path.
    link_to "#{localized_locale_name(locale)} (#{locale})",
      url_for(locale: locale), class: 'dropdown-item'
  end

  # Returns a locale name translated to the original language
  def localized_locale_name(locale)
    upcased_locale = locale.to_s.upcase

    # Normalizes string of languages names
    I18nData.languages(upcased_locale)[upcased_locale].split(';').map(&:strip).first
  end
end
