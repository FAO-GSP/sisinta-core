# Profile Type administration menu.
#
# i18n-tasks-use t('activerecord.models.profile_type')
# i18n-tasks-use t('activerecord.attributes.profile_type.default')
# i18n-tasks-use t('activerecord.attributes.profile_type.value')
# i18n-tasks-use t('activerecord.attributes.profile_type.translated_value')
ActiveAdmin.register ProfileType do
  menu parent: 'lookup_tables'

  permit_params :default, :value_es, :value_en

  # Filters not needed here
  config.filters = false

  index do
    id_column

    column :default
    column ProfileType.human_attribute_name(:translated_value, language: locale.upcase), "value_#{I18n.locale}"
    column I18n.t('translations') do |profile_type|
      I18n.available_locales.collect do |locale|
        status_tag profile_type.translations.dig(locale, :value).present?, label: locale
      end and nil # Don't return anything from loop
    end

    actions
  end

  show do |profile_type|
    attributes_table do
      row :default

      profile_type.translated_attributes.keys.each do |attribute|
        I18n.available_locales.collect do |locale|
          row(ProfileType.human_attribute_name(:translated_value, language: locale.upcase)) { |type| type.send([attribute, locale].join('_').to_sym) }
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      profile_type.translated_attributes.keys.each do |attribute|
        I18n.available_locales.each do |locale|
          f.input [attribute, locale].join('_'),
            label: ProfileType.human_attribute_name(:translated_value, language: locale.upcase)
        end
      end

      f.input :default
    end

    f.actions
  end
end
