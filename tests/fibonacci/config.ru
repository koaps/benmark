require 'camping'

require './camping.fibonacci.rb'
Fibonacci.create if Fibonacci.respond_to? :create
run Fibonacci
