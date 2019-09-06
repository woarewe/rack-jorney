# frozen_string_literal: true

require 'rack'
require 'pry-byebug'

class HelloWorld
  def call(env)
    [200, { 'Content-Type' => 'text/plain' }, ["Hello World\n"]]
  end
end

class SimpleMiddleware
  attr_reader :app
  
  def initialize(app)
    @app = app
  end

  def call(env)
    before = Time.now.to_i
    status, headers, body = app.call(env)
    after = Time.now.to_i
    message = "Request took about #{after - before} second(s)"
    [status, headers, body << message]
  end
end


use SimpleMiddleware
run HelloWorld.new
