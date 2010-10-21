Gem::Specification.new do |s|
  s.name        = "mock-server"
  s.version     = "0.1.1"
  s.summary     = %{A quick way of mocking an external web service you want to consume.}
  s.authors     = ["Damian Janowski"]
  s.email       = ["djanowski@dimaion.com"]
  s.homepage    = "http://github.com/djanowski/mock-server"
  s.files       = ["lib/mock_server.rb", "README.markdown", "test/mock_server_test.rb"]

  s.add_dependency "sinatra"
end
