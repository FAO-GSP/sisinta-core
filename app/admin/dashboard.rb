ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel I18n.t 'admin.dashboard.admin_users' do
          ul do
            User.admins.decorate.each do |user|
              li link_to(user.name_and_email, admin_user_path(user))
            end
          end
        end
      end

      column do
        panel I18n.t 'admin.dashboard.how_to_translate' do
        end
      end
    end
  end
end
