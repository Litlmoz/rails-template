copy_file "Procfile"

remove_file "config/puma.rb"

file "config/puma.rb", <<-RUBY
plugin :tmp_restart
plugin :heroku
RUBY

copy_file "lib/puma/plugin/heroku.rb"
