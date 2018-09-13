# Profile Type administration menu.
#
# i18n-tasks-use t('activerecord.models.profile_type')
# i18n-tasks-use t('activerecord.attributes.profile_type.default')
# i18n-tasks-use t('activerecord.attributes.profile_type.value')
ActiveAdmin.register ProfileType do
  menu parent: I18n.t('admin.menu.lookup_tables')

  permit_params :value, :default

  # Don't load every profile on index
  remove_filter :profiles
end
