require 'webmachine'
require 'sequel'
require 'erb'

$DB = Sequel.connect("postgres://dbhost/benmark?user=benmark&password=benmark")

$LAYOUT = ERB.new(<<-CODE)
<!DOCTYPE html>
<html>
  <body>
    <h1>Hello from Webmachine</h1>
    <h3>Webrick Server, DB Backend</h3>
    <ul>
    <% @items.each do |item| %>
      <li><%= item.first.last %></li>
    <% end %>
    </ul>
  </body>
</html>
CODE

class MyIndex < Webmachine::Resource
  def resource_exists?
    @items = $DB[:tests].select(:item).all
  end

  def to_html
    $LAYOUT.result(binding)
  end
end

MyApp = Webmachine::Application.new do |app|
  # Configure your app like this:
  app.configure do |config|
    config.port = 8000
  end
  # And add routes like this:
  app.routes do
    add [], MyIndex
  end
end.run
