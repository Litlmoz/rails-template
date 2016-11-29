
def apply_template!
  template "Gemfile.tt", :force => true # define default gems

  apply "app/assets/assets_template.rb" # import Bootstrap js and css
  apply "app/helpers/helper_templates.rb" # default helper methods
  apply "config/application_template.rb" # config logger, default generators
  apply "config/puma_template.rb" # config puma server setttings
  apply "app/views/layouts/application/_partials.rb" # eg. navbar & footer
  gsub_file "config/cable.yml", /url: .*/, "url: <%= ENV['REDIS_URL'] %>"
end

apply_template!

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
