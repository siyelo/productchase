module TwitterSecrets
  class Application < Rails::Application
    config.before_configuration do
      secrets = Rails.root.join 'config', 'twitter_secrets.yml'

      ENV.update YAML.load_file(secrets) if File.exists? secrets
    end
  end
end
