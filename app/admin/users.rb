# User administration menu.
#
# i18n-tasks-use t('activerecord.attributes.user.admin')
# i18n-tasks-use t('activerecord.attributes.user.name')
# i18n-tasks-use t('activerecord.attributes.user.role')
ActiveAdmin.register User do
  permit_params :name, :email, :role, :password, :password_confirmation

  before_action :allow_update_without_password, only: [:update]

  controller do
    # Admins don't need to provide password to modify user data
    def allow_update_without_password
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end
  end

  index do
    selectable_column

    column :name
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at

    actions
  end

  filter :email
  filter :name
  filter :role, as: :select, collection: User::roles
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :email
      f.input :name
      f.input :role, as: :select, collection: User::roles.keys
      f.input :password, required: false
      f.input :password_confirmation, required: false
    end

    f.actions
  end
end
