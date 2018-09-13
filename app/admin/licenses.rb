# License administration menu.
# 
# i18n-tasks-use t('activerecord.models.license')
# i18n-tasks-use t('activerecord.attributes.license.profiles')
# i18n-tasks-use t('activerecord.attributes.license.name')
# i18n-tasks-use t('activerecord.attributes.license.url')
# i18n-tasks-use t('activerecord.attributes.license.acronym')
# i18n-tasks-use t('activerecord.attributes.license.statement')
# i18n-tasks-use t('activerecord.attributes.license.default')
ActiveAdmin.register License do
  menu parent: I18n.t('admin.menu.lookup_tables')

  permit_params :name, :url, :acronym, :statement, :default

  # Don't load every profile on index
  remove_filter :profiles
end
