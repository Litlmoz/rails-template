file "app/views/application/_flash.html.erb", <<-CODE
<% flash.each do |type, msg| %>
  <div class="alert alert-<%= bootstrap_type(type) %> alert-dismissable" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <p><%= msg %></p>
  </div>
<% end %>
CODE

