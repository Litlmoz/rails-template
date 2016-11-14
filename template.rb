def source_paths
  Array(super)
  [File.expand_path(File.dirname(__FILE__))]
end

def apply_template!
  application do
    "logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.view_specs false
      g.helper_specs false
      g.stylesheets     false
      g.javascripts     false
    end"
  end
  remove_file "Gemfile"
  remove_file "config/puma.rb"
  apply "app/assets_template.rb"
  apply "app/helpers/application_helper.rb"
  copy_file "lib/puma/plugin/heroku.rb"
  copy_file "config/puma.rb"
  copy_file "app/serializers/hash_serializer.rb"
  copy_file "Procfile"
  gsub_file "config/cable.yml", /url: .*/, "url: <%= ENV['REDIS_URL'] %>"
end

apply_template!
run "touch Gemfile"
apply "gemfile_template.rb"

after_bundle do
  remove_dir 'test'
  generate "simple_form:install"
  generate "simple_form:install --bootstrap"
  generate "rspec:install"
  rails_command "db:create"
  rails_command "db:migrate"
end
