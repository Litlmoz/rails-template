copy_file "app/assets/stylesheets/application.scss"
copy_file "app/assets/stylesheets/main.scss.erb"

remove_file "app/assets/stylesheets/application.css"
remove_file "app/assets/javascripts/application.js"

copy_file "app/assets/javascripts/application.js"
