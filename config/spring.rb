%w[
  .ruby-version
  .rbenv-vars
  .envrc
  tmp/restart.txt
  tmp/caching-dev.txt
].each { |path| Spring.watch(path) }
