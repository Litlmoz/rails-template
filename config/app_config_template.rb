##### Set defaults for generated Scaffolding, and log outputs
application do <<-RUBY

    # Sets Rails to log to stdout, prints SQL queries
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)

    # Generate Rspec fixtures without view, helper specs and asset files
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.view_specs false # supress view specs
      g.controller_specs false # supress controller specs
      g.helper_specs false # supress helper specs
      g.stylesheets false # supress default css files
      g.javascripts false # supress default css files
    end
RUBY
end

##### Specify Redis port for ActionCable
gsub_file "config/cable.yml", /url: .*/, "url: <%= ENV['REDIS_URL'] %>"

##### Configure Dev Mailer
mailer_regex = /config\.action_mailer\.raise_delivery_errors = false\n/

comment_lines "config/environments/development.rb", mailer_regex

insert_into_file "config/environments/development.rb", :after => mailer_regex do
  <<-RUBY

  # Ensure mailer works in dev environment.
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {:host => 'localhost:5000'}
  config.action_mailer.asset_host = "http://localhost:5000"

  Rails.application.routes.default_url_options[:host] = 'localhost:5000'
  RUBY
end

##### Add popular file types to the assets pre-compile list
append_file "config/initializers/assets.rb" do
  <<-RUBY

# Pre-compile additional assets.
Rails.application.config.assets.precompile << proc do |path|
  true if path =~ /\.(eot|svg|ttf|woff|png)\z/
end
  RUBY
end

##### Create Heroku review app config file
template "app.json.tt"

##### Create default enviroment variables file
copy_file "example.env", ".env"

##### Ignore .env File
insert_into_file ".gitignore", :after => /.byebug_history\n/ do
  <<-CODE

# Ignore Enviroment Variable doc
.env
  CODE
end
