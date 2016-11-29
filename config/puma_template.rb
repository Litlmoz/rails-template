remove_file "config/puma.rb"

file "config/puma.rb", <<-RUBY
plugin :tmp_restart
plugin :heroku
RUBY

template "lib/puma/plugin/heroku.rb.tt" # Config Puma server to Heroku defaults
template "Procfile.tt" # Specify App launch commands
