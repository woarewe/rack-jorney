# frozen_string_literal: true

require 'rack'
require 'pry-byebug'

class HelloWorld
  def call(env)
    [200, { 'Content-Type' => 'text/plain' }, ["Hello World\n"]]
  end
end

Rack::Handler::WEBrick.run HelloWorld.new
