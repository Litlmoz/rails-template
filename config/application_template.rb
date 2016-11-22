application do <<-RUBY

    # Sets Rails to log to stdout, prints SQL queries
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)

    # Generate Rspec fixtures without view, helper specs and asset files
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.view_specs false
      g.helper_specs false
      g.stylesheets false
      g.javascripts false
    end
RUBY
end
