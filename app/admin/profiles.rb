# Profile administration menu
#
# Dynamic translation strings used
# i18n-tasks-use t('activerecord.models.profile')
# i18n-tasks-use t('activerecord.attributes.profile.created_at')
# i18n-tasks-use t('activerecord.attributes.profile.date')
# i18n-tasks-use t('activerecord.attributes.profile.identifier')
# i18n-tasks-use t('activerecord.attributes.profile.order')
# i18n-tasks-use t('activerecord.attributes.profile.public')
# i18n-tasks-use t('activerecord.attributes.profile.updated_at')
# i18n-tasks-use t('activerecord.attributes.profile.user')
ActiveAdmin.register Profile do
  permit_params :user_id, :date, :public, :order, :identifier
end
