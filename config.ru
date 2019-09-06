# frozen_string_literal: true

require 'rack'
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
    puts 'First middleware call'
    app.call(env)
  end
end

class SecondMiddleware < Middleware::Base
  def call(env)
    puts 'Second middleware call'
    app.call(env)
  end
end

use FirstMiddleware
use SecondMiddleware
run HelloWorld.new
