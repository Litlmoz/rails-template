require "fileutils"
require "shellwords"

RAILS_REQUIREMENT = "~> 5.0.0"

def apply_template!
  assert_minimum_rails_version
  add_template_repository_to_source_path

  ##### Replace default Gemfile
  template "Gemfile.tt", :force => true

  @description = ask("Please describe App:\n")
  ##### Replace default README
  template "README.md.tt", :force => true
  ##### Config App settings
  apply "config/app_config_template.rb"
  ##### Config puma server setttings
  apply "config/puma_template.rb"

  ##### Import Bootstrap and jQuery2
  apply "app/assets/assets_template.rb"
  ##### Define Application Helper methods
  template "app/helpers/application_helper.rb.tt", :force => true
  ##### Define Serializer to handle json data into hash
  template "app/serializers/hash_serializer.rb.tt"

  after_bundle do
    ##### Install SimpleForm
    generate "simple_form:install" # initialize gem
    generate "simple_form:install --bootstrap" # initialize SimpleForm Bootstrap

    ##### Install Rspec
    generate "rspec:install"

    ##### Install Devise
    generate "devise:install"

    ##### Add custom Application layout, _partials, and scaffold views
    apply "app/views/views_template.rb"

    ##### Customize bin/setup tasks
    copy_file "bin/setup", :force => true #overwrite setup tasks
  end
end

def app_description
  @description ||= "Default Rails 5 App description. This description is displayed within README.md and app.json file."
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
