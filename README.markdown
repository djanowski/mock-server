# MockServer #

A quick way of mocking an external web service you want to consume.

## Usage ##

You're writing a feature that needs to connect to an external web service
(anything served by HTTP). You wonder how to test that. Your options
are to stub methods in Net::HTTP and equivalents, but by doing that you
are tying yourself to an implementation detail. The ideal thing to do
is to lay out an environment where your code can still run, connect to
a web server, send out requests and get responses back. Enter MockServer.

    class RSSFeedTest < Test::Unit::TestCase
      extend MockServer::Methods

      mock_server {
        get "/feed.xml" do
          <<-EOS
          <?xml version="1.0"?>
          <rss version="2.0">
            <channel>
              <title>A mock website</title>
              <link>http://example.com/</link>
            </channel>
          </rss>
          EOS
        end
      }

      def test_rss_feed
        # YourAwesomeComponent should connect to http://localhost:4000.
        # (you *are* putting those URLs in an environment-aware config file, right?)

        posts = YourAwesomeComponent.load_posts

        assert_equal "A mock website", post.first.channel.title
      end
    end

Yes, things happening inside the `mock_server` call are just a regular Sinatra application. w00t!

## License ##

MIT.
