# Keep session data in memcached instead of cookies.
Rails.application.config.session_store :cache_store
