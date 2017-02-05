##### Add Bootsrap and jQuery2 JavaScript stylesheets
remove_file "app/assets/javascripts/application.js"

file "app/assets/javascripts/application.js", <<-JS
//= require jquery2
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .
JS

##### Add Bootsrap CSS stylesheets
remove_file "app/assets/stylesheets/application.css"

file "app/assets/stylesheets/application.scss", <<-CSS
@import
  'bootstrap-sprockets',
  'bootstrap',
  'main';
CSS

##### Add Bootsrap Variables and create custom CSS stylesheet
file "app/assets/stylesheets/main.scss.erb", <<-CSS
@import 'bootstrap/variables';

.alert-notice {
  @extend .alert-success;
}

.alert-alert {
  @extend .alert-danger;
}

img {
  @extend .img-responsive;
}

.validation-error {
  margin-top: 2px;
  color: $brand-danger;
  font-size: $font-size-small;
}

body {
  padding-top: 30px;
}

.page-header {
  background-color: #FCC;
  margin-top: 0;
  padding: 15px;
}

.navbar-brand {
  min-width: 50px;
  padding: 8px;
}
CSS
