path = Rails.root.join("config", "pemilu_database.yml")
if File.exist?(path)
  config      = YAML::load(ERB.new(File.read(path)).result)
  PEMILU_DB = config[Rails.env]
end
