module Presenters
  class Application < Rails::Application
    config.before_configuration do
      config.autoload_paths << Rails.root.join('app/presenters')
    end
  end
end
