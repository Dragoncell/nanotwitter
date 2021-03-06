require File.expand_path '../../test_helper.rb', __FILE__

class TestTweetCreate < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_create_tweet
    user = User.find_by(username: "testtweet0")
    unless user.nil?
      user.destroy
    end

    put '/api/v1/register/testtweet0/tweetpassword0'
    user = JSON.parse(last_response.body)
    user_id = user["id"]

    put "/api/v1/users/#{user_id}/tweets/tall"
    tweet = JSON.parse(last_response.body)
    assert_equal tweet["content"], "tall"
    assert_equal tweet["user_id"], user_id
    #assert_equal tweet["nickname"], ""

    user = User.find_by(username: "testtweet0")
    tweet = Tweet.find_by(content: "tall")
    user.destroy
    tweet.destroy
  end
end
