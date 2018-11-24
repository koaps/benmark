require 'webmachine'

class MyHello < Webmachine::Resource
  def to_html
    <<-HTML
<!DOCTYPE html>
<html>
  <body>
    <h1>Hello from Webmachine</h1>
    <h3>Webrick Server</h3>
  </body>
</html>
    HTML
  end
end

MyApp = Webmachine::Application.new do |app|
  # Configure your app like this:
  app.configure do |config|
    config.port = 8000
  end
  # And add routes like this:
  app.routes do
    add [], MyHello
  end
end.run
