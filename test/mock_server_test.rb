require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "mock_server"))

require "test/unit"
require "open-uri"

class HelloWorldSinatra < Sinatra::Base
  get "/" do
    "Hello"
  end
end

class MockServerTest < Test::Unit::TestCase
  def setup
    @server = MockServer.new(HelloWorldSinatra)
    @server.start
  end

  def test_server
    assert_equal "Hello", open("http://localhost:4000").read
  end
end

HelloWorldRackBuilder = Rack::Builder.new do
  run lambda {|env|
    [200, {"Content-Type" => "text/plain", "Content-Length" => "7"}, ["Rackup!"]]
  }
end

class MockServerRackBuilderTest < Test::Unit::TestCase
  def setup
    @server = MockServer.new(HelloWorldRackBuilder, 4001)
    @server.start
  end

  def test_server
    assert_equal "Rackup!", open("http://localhost:4001").read
  end end

class MockServerMethodsTest < Test::Unit::TestCase
  extend MockServer::Methods

  mock_server(4002) {
    get "/" do
      "Goodbye"
    end
  }

  def test_server
    assert_equal "Goodbye", open("http://localhost:4002").read
  end
end
