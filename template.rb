def source_paths
  Array(super)
  [File.expand_path(File.dirname(__FILE__))]
end

def apply_template!
  apply "app/assets/assets_template.rb" # import bootstrap js and css
  apply "app/helpers/helper_templates.rb" # date format helper, json serializer
  template "Gemfile.tt", :force => true # define default gems
  apply "config/application_template.rb" # config logger, default generators
  apply "config/puma_template.rb" # config puma server setttings
  apply "lib/partials.rb" # partial views
  gsub_file "config/cable.yml", /url: .*/, "url: <%= ENV['REDIS_URL'] %>"
end

apply_template!

after_bundle do
  generate "simple_form:install" # initialize SimpleForm
  generate "simple_form:install --bootstrap" # initialize SimpleForm Bootstrap
  generate "rspec:install" # install Rspec
  remove_dir "test" # remove unused test specs
  remove_dir "lib/templates/erb/scaffold" # remove default scaffolds
  copy_file "lib/templates/erb/scaffold/_form.html.erb" # custom form scaffold
  copy_file "lib/templates/erb/scaffold/index.html.erb" # custom index scaffold
  rails_command "db:create"
  rails_command "db:migrate"
end
