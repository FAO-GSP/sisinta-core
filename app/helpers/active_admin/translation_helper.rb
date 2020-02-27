module ActiveAdmin::TranslationHelper
  # Returns a list of accessor for each locale and translated attribute (e.g.
  # value_es, value_en)
  def translation_accessors(model, attributes: nil, locales: nil)
    # Every translated attribute by default
    attributes ||= model.translated_attribute_names
    # Every locale by default
    locales ||= I18n.available_locales

    attributes.collect do |attribute|
      locales.each do |locale|
        [attribute, locale].join('_') 
      end
    end
  end
end
