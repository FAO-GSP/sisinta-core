Mobility.configure do |config|
  config.default_backend = :container
  config.accessor_method = :translates
  config.query_method = :i18n

  # Default to I18n.default_locale
  config.default_options[:fallbacks] = true

  # Dirty tracking is disabled by default. Uncomment this line to enable it.
  # If you enable this, you should also enable +locale_accessors+ by default
  # (see below).
  #
  # config.default_options[:dirty] = true

  # Uncomment to enable locale_accessors by default on models. A true value
  # will use the locales defined either in
  # Rails.application.config.i18n.available_locales or I18n.available_locales.
  # If you want something else, pass an array of locales instead.
  #
  # config.default_options[:locale_accessors] = true

  # Uncomment to enable fallthrough accessors by default on models. This will
  # allow you to call any method with a suffix like _en or _pt_br, and Mobility
  # will catch the suffix and convert it into a locale in +method_missing+. If
  # you don't need this kind of open-ended fallthrough behavior, it's better
  # to use locale_accessors instead (which define methods) since method_missing
  # is very slow. (You can use both fallthrough and locale accessor plugins
  # together without conflict.)
  #
  # Note: The dirty plugin enables fallthrough_accessors by default.
  #
  # config.default_options[:fallthrough_accessors] = true
end
