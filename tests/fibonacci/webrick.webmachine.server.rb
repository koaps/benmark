require 'webmachine'
require 'erb'

$LAYOUT = ERB.new(<<-CODE)
<!DOCTYPE html>
<html>
  <body>
    <h1>Hello from Webmachine</h1>
    <h3>Reel Server, Webmachine, Fibonacci</h3>
      <%= @fibnums %>
  </body>
</html>
CODE

class MyIndex < Webmachine::Resource
  def fib(n)
    n < 2 ? n : fib(n - 1) + fib(n - 2)
  end

  def run_fib
    fibnums = []
    num=20
    num.times do |i|
      fibnums.push fib(i)
    end
    fibnums
  end

  def resource_exists?
    @fibnums = run_fib
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
