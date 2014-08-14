module TwitterSecrets
  class Application < Rails::Application
    config.before_configuration do
      secrets = Rails.root.join 'config', 'twitter_secrets.yml'

      return unless File.exists? secrets

      ENV.update YAML.load_file(secrets)
    end
  end
end
