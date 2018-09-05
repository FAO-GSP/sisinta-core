# Devise Registrations customization.
module DeviseOverride
  class RegistrationsController < Devise::RegistrationsController
    # Unlike after_sign_in_path_for, this method is already defined on the
    # devise controller so it doesn't work when defined on
    # ApplicationController.
    #
    # By default, `after_sign_up_path_for` goes to `after_sign_in_path_for` so it is already covered.
    def after_inactive_sign_up_path_for(resource)
      localized_root_path
    end
  end
end
