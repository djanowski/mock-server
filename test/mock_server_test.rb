require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "mock_server"))

require "test/unit"
require "ruby-debug"
require "open-uri"

class MockServerTest < Test::Unit::TestCase
  @@server = MockServer.new do
    get "/" do
      "Hello"
    end
  end

  def setup
    @@server.start
  end

  def test_server
    assert_equal "Hello", open("http://localhost:4000").read
  end
end

class MockServerMethodsTest < Test::Unit::TestCase
  extend MockServer::Methods

  mock_server(4001) {
    get "/" do
      "Goodbye"
    end
  }

  def test_server
    assert_equal "Goodbye", open("http://localhost:4001").read
  end
end
