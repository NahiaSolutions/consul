module Consul
  class Application < Rails::Application
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es, :en]
  
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Add lib to the autoload path
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'Madrid'
    config.active_job.queue_adapter = :delayed_job

    # CONSUL specific custom overrides
    # Read more on documentation:
    # * English: https://github.com/consul/consul/blob/master/CUSTOMIZE_EN.md
    # * Spanish: https://github.com/consul/consul/blob/master/CUSTOMIZE_ES.md
    #
    config.autoload_paths << "#{Rails.root}/app/controllers/custom"
    config.autoload_paths << "#{Rails.root}/app/models/custom"
    config.paths['app/views'].unshift(Rails.root.join('app', 'views', 'custom'))
  end
end
