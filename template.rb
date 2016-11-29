require "fileutils"
require "shellwords"

RAILS_REQUIREMENT = "~> 5.0.0"

def apply_template!
  assert_minimum_rails_version
  add_template_repository_to_source_path

  template "README.md.tt", :force => true # replace default README
  template "Gemfile.tt", :force => true # define default gems

  apply "app/assets/assets_template.rb" # import Bootstrap js and css
  apply "app/helpers/helper_templates.rb" # default helper methods
  apply "app/views/layouts/application/_partials.rb" # eg. navbar & footer

  apply "config/application_template.rb" # configure app
  apply "config/puma_template.rb" # config puma server setttings

  template "app.json.tt" # Heroku review app config

  after_bundle do
    generate "simple_form:install" # initialize SimpleForm
    generate "simple_form:install --bootstrap" # initialize SimpleForm Bootstrap

    generate "rspec:install" # install Rspec

    remove_dir "test" # remove unused test specs

    remove_dir "lib/templates/erb/scaffold" # remove default scaffolds
    copy_file "lib/templates/erb/scaffold/_form.html.erb" # form defaults
    copy_file "lib/templates/erb/scaffold/index.html.erb" # index#view defaults

    # initialize Postgres database
    rails_command "db:create"
    rails_command "db:migrate"
  end
end

def assert_minimum_rails_version
  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
           "You are using #{rails_version}. Continue anyway?"
  exit 1 if no?(prompt)
end

# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    source_paths.unshift(tempdir = Dir.mktmpdir("rails-template-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git :clone => [
      "--quiet",
      "https://github.com/litlmoz/rails-template.git",
      tempdir
    ].map(&:shellescape).join(" ")
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

apply_template!
