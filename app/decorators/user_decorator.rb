# User presentation methods
class UserDecorator < Draper::Decorator
  def name
    object.name.titleize
  end

  def email
    object.email.downcase
  end

  # Generates a string like "Name (email)"
  def name_and_email
    "#{name} (#{email})"
  end
end
