##### Add Application layout view
copy_file "app/views/layouts/application.html.erb", :force => true

##### Blank Favicon Partial
copy_file "app/views/application/_favicon.html.erb"

##### Navbar Partial
copy_file "app/views/application/_navigation.html.erb"

##### Notifications Partial
copy_file "app/views/application/_flash.html.erb"

##### Footer Partial
copy_file "app/views/application/_footer.html.erb"

##### Default _Form Scaffold
copy_file "lib/templates/erb/scaffold/_form.html.erb", :force => true

##### Default #Index View Scaffold
copy_file "lib/templates/erb/scaffold/index.html.erb"
