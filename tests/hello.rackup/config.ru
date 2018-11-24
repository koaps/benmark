run lambda { |env|
  [200, { 'Content-Type' => 'text/html' }, "<!DOCTYPE html><html><body><h1>Hello from Rack</h1></body></html>"]
}
