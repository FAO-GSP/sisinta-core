# MetadataEntry per Profile administration menu.
#
# i18n-tasks-use t('activerecord.models.metadata_entry')
# i18n-tasks-use t('activerecord.attributes.metadata_entry.field_name')
# i18n-tasks-use t('activerecord.attributes.metadata_entry.value')
ActiveAdmin.register MetadataEntry do
  belongs_to :profile
  navigation_menu :profile

  permit_params :metadata_type_id

  # Filters not needed here
  config.filters = false

  decorate_with MetadataEntryDecorator

  index do
    selectable_column

    column :field_name
    column :value

    actions
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :metadata_type, as: :select,
        collection: grouped_options_for_select(MetadataType.grouped_values, f.object.metadata_type_id)
    end

    f.actions
  end
end
