# Keep session data in memcached instead of cookies.
Rails.application.config.session_store :mem_cache_store
