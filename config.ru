# frozen_string_literal: true

require 'pry-byebug'

class HelloWorld
  def call(env)
    [200, { 'Content-Type' => 'text/plain' }, ["Hello World\n"]]
  end
end

module Middleware
  class Base
    attr_reader :app

    def initialize(app)
      @app = app
    end

    def call(_env)
      raise NotImplementedError
    end
  end
end

class FirstMiddleware < Middleware::Base
  def call(env)
    puts 'First middleware: before call'
    status, headers, body = app.call(env)
    puts 'First middleware: after call'
    [status, headers, body << "First middleware body\n"]
  end
end

class SecondMiddleware < Middleware::Base
  def call(env)
    puts 'Second middleware: before call'
    status, headers, body = app.call(env)
    puts 'Second middleware: after call'
    [status, headers, body << "Second middleware body\n"]
  end
end

use FirstMiddleware
use SecondMiddleware
run HelloWorld.new
