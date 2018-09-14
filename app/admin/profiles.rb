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

  decorate_with ProfileDecorator

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
