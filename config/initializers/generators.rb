# Configuration for Rails generators.

Rails.application.config.generators do |g|
  # Restore default scaffold generator because Devise uses InheritedResources.
  g.scaffold_controller = :scaffold_controller
end
