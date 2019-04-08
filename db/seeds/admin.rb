# Creates an admin if there are none.
unless User.admins.any?
  email = ENV['SISINTA_ADMIN_EMAIL']
  name = ENV['SISINTA_ADMIN_NAME']
  password = ENV['SISINTA_ADMIN_PASSWORD']

  Rails.logger.info
  Rails.logger.info 'Creating initial admin user'
  Rails.logger.info

  begin
    User.create!(
      name: name,
      email: email,
      password: password,
      password_confirmation: password,
      role: :admin,
      confirmed_at: Date.today
    )
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e.message
    Rails.logger.error "Missing 'SISINTA_ADMIN_EMAIL' param for admin creation" unless email
    Rails.logger.error "Missing 'SISINTA_ADMIN_NAME' param for admin creation" unless name
    Rails.logger.error "Missing 'SISINTA_ADMIN_PASSWORD' param for admin creation" unless password

    raise
  end
end
