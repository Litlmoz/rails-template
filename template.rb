def source_paths
  Array(super)
  [File.expand_path(File.dirname(__FILE__))]
end

def apply_template!
  apply "gem_template.rb" # define default gems
  apply "config/application_template.rb" # config logger, default generators
  apply "config/puma_template.rb" # config puma server setttings
  apply "app/assets/assets_template.rb" # import bootstrap js and css
  apply "app/helpers/helper_templates.rb" # date format helper, json serializer
  gsub_file "config/cable.yml", /url: .*/, "url: <%= ENV['REDIS_URL'] %>"
end

apply_template!

after_bundle do
  remove_dir "test" # remove unused test specs
  generate "simple_form:install"
  generate "simple_form:install --bootstrap"
  generate "rspec:install"
  rails_command "db:create"
  rails_command "db:migrate"
end
