# Metadata Type administration menu.
#
# i18n-tasks-use t('activerecord.models.metadata_type')
# i18n-tasks-use t('activerecord.attributes.metadata_type.field_name')
# i18n-tasks-use t('activerecord.attributes.metadata_type.value')
# i18n-tasks-use t('activerecord.attributes.metadata_type.translated_value')
ActiveAdmin.register MetadataType do
  menu parent: 'lookup_tables'

  permit_params :field_name, :value_es, :value_en

  # Filter by field_name only
  filter :field_name, as: :select, collection: MetadataType::FIELD_NAMES

  decorate_with MetadataTypeDecorator

  index do
    id_column

    column :field_name
    column MetadataType.human_attribute_name(:translated_value, language: locale.upcase), "value_#{I18n.locale}"
    column I18n.t('translations') do |metadata_type|
      I18n.available_locales.collect do |locale|
        status_tag metadata_type.translations.dig(locale, :value).present?, label: locale
      end and nil # Don't return anything from loop
    end

    actions
  end

  show do |metadata_type|
    attributes_table do
      row :field_name

      metadata_type.translated_attribute_names.each do |attribute|
        I18n.available_locales.collect do |locale|
          row(MetadataType.human_attribute_name(:translated_value, language: locale.upcase)) { |type| type.send([attribute, locale].join('_').to_sym) }
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :field_name, as: :select, collection: MetadataType::FIELD_NAMES

      metadata_type.translated_attribute_names.each do |attribute|
        I18n.available_locales.each do |locale|
          f.input [attribute, locale].join('_'),
            label: MetadataType.human_attribute_name(:translated_value, language: locale.upcase)
        end
      end
    end

    f.actions
  end
end
