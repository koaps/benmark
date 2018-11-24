require 'camping'

require './hello.db.rb'
Hello.create if Hello.respond_to? :create
run Hello
