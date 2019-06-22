# Profile administration menu.
#
# i18n-tasks-use t('activerecord.models.profile')
# i18n-tasks-use t('activerecord.attributes.profile.date')
# i18n-tasks-use t('activerecord.attributes.profile.contact')
# i18n-tasks-use t('activerecord.attributes.profile.country_code')
# i18n-tasks-use t('activerecord.attributes.profile.created_at')
# i18n-tasks-use t('activerecord.attributes.profile.identifier')
# i18n-tasks-use t('activerecord.attributes.profile.license')
# i18n-tasks-use t('activerecord.attributes.profile.order')
# i18n-tasks-use t('activerecord.attributes.profile.public')
# i18n-tasks-use t('activerecord.attributes.profile.source')
# i18n-tasks-use t('activerecord.attributes.profile.type')
# i18n-tasks-use t('activerecord.attributes.profile.updated_at')
# i18n-tasks-use t('activerecord.attributes.profile.user')
ActiveAdmin.register Profile do
  permit_params :user_id, :date, :public, :order, :identifier, :source,
    :contact, :type_id, :license_id, :country_code

  # Don't load every association on index
  remove_filter :user, :location, :layers, :metadata_entries, :metadata_types

  decorate_with ProfileDecorator

  sidebar I18n.t('admin.sidebar.related'), only: [:show, :edit] do
    ul do
      li link_to "#{Layer.model_name.human(count: 2)} (#{resource.layers.count})", admin_profile_layers_path(resource)
      li link_to "#{MetadataType.model_name.human(count: 2)} (#{resource.metadata_entries.count})", admin_profile_metadata_entries_path(resource)
    end
  end

  show do |profile|
    attributes_table do
      row :identifier
      row :country_code
      row :user
      row :contact
      row :source
      row :type
      row :order
      row :date
      row :license
      row :public
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  index do
    selectable_column

    column :id
    column :identifier
    column :user
    column :license do |profile|
      link_to profile.license.acronym, [:admin, profile.license]
    end
    column :source
    column :country_code

    actions
  end
end
