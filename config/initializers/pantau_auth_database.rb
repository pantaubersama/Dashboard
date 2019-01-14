path = Rails.root.join("config", "pantau_auth_database.yml")
if File.exist?(path)
  config      = YAML::load(ERB.new(File.read(path)).result)
  PANTAU_AUTH_DB = config[Rails.env]
end
