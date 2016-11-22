copy_file "Procfile"

remove_file "config/puma.rb"
file 'config/puma.rb', <<-RUBY
plugin :tmp_restart
plugin :heroku
RUBY

lib "lib/puma/plugin/heroku.rb"
