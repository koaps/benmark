require 'camping'

Camping.goes :Fibonacci

module Fibonacci
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

  module Controllers
    class Index
      def get
        @fibnums = run_fib
        render :fibview
      end
    end
  end

  module Views
    def layout
      html do
        body { self << yield }
      end
    end

    def fibview
      h1 "Hello from Camping Fibonacci"
      p @fibnums
    end
  end
end
