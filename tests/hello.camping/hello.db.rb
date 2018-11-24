require 'camping'
require 'sequel'

Camping.goes :Hello

module Hello

  DB = Sequel.connect("jdbc:postgresql://dbhost/benmark?user=benmark&password=benmark")

  module Models
    class Test < Sequel::Model(:tests); end
  end
  module Controllers
    class Index
      def get
	@items = Test.all
        render :hello
      end
    end
  end

  module Views
    def layout
      html do
        body { self << yield }
      end
    end
      
    def hello
      h1 "Hello from Camping"
      h3 "DB Backend"
      ul do
        @items.each do |item|
          li item.item
        end
      end
    end
  end
end
