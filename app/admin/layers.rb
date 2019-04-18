# Profile nested Layer administration menu.
#
# i18n-tasks-use t('activerecord.models.layer')
# i18n-tasks-use t('activerecord.attributes.layer.identifier')
# i18n-tasks-use t('activerecord.attributes.layer.top')
# i18n-tasks-use t('activerecord.attributes.layer.bottom')
# i18n-tasks-use t('activerecord.attributes.layer.designation')
# i18n-tasks-use t('activerecord.attributes.layer.bulk_density')
# i18n-tasks-use t('activerecord.attributes.layer.ca_co3')
# i18n-tasks-use t('activerecord.attributes.layer.coarse_fragments')
# i18n-tasks-use t('activerecord.attributes.layer.ecec')
# i18n-tasks-use t('activerecord.attributes.layer.conductivity')
# i18n-tasks-use t('activerecord.attributes.layer.organic_carbon')
# i18n-tasks-use t('activerecord.attributes.layer.ph')
# i18n-tasks-use t('activerecord.attributes.layer.clay')
# i18n-tasks-use t('activerecord.attributes.layer.silt')
# i18n-tasks-use t('activerecord.attributes.layer.sand')
# i18n-tasks-use t('activerecord.attributes.layer.water_retention')
ActiveAdmin.register Layer do
  belongs_to :profile
  navigation_menu :profile

  permit_params :identifier, :top, :bottom, :designation, :bulk_density,
    :ca_co3, :coarse_fragments, :ecec, :conductivity, :organic_carbon,
    :ph, :clay, :silt, :sand, :water_retention

  # Don't load every association on index
  remove_filter :profile

  decorate_with LayerDecorator

  index do
    selectable_column

    column :identifier
    column :top
    column :bottom
    column :designation

    actions
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :identifier
      f.input :top
      f.input :bottom
      f.input :designation
      f.input :bulk_density
      f.input :ca_co3
      f.input :coarse_fragments
      f.input :ecec
      f.input :conductivity
      f.input :organic_carbon
      f.input :ph
      f.input :clay
      f.input :silt
      f.input :sand
      f.input :water_retention
    end

    f.actions
  end
end
