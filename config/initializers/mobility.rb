Mobility.configure do
  plugins do
    backend :container

    reader
    writer

    active_record

    # `i18n` is the default scope.
    query
    fallbacks
    locale_accessors

    # Previously implicit.
    cache
    presence
    default

    # Enables `translated_attributes` and the like.
    attribute_methods
  end
end
