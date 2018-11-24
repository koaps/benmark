require 'camping'

Camping.goes :Hello

module Hello
  module Controllers
    class Index
      def get
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
    end
  end
end
