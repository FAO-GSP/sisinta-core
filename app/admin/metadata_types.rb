# Metadata Type administration menu.
#
# i18n-tasks-use t('activerecord.models.metadata_type')
ActiveAdmin.register MetadataType do
  # FIXME It's only loaded on startup, with default locale
  menu parent: I18n.t('admin.menu.lookup_tables')

  permit_params :field_name, :value, :description
end
