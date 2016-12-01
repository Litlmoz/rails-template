##### Point Puma server configs to Heroku plugin
remove_file "config/puma.rb"

file "config/puma.rb", <<-RUBY
plugin :tmp_restart
plugin :heroku
RUBY

##### Config Puma server to Heroku defaults
template "lib/puma/plugin/heroku.rb.tt"

##### Specify App server start preferences
template "Procfile.tt"
