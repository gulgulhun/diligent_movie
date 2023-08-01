require "test_helper"

class MoviesClientTest < ActiveSupport::TestCase
  def setup
    @result = MoviesClient.search('wild', 1)
  end

  test 'MoviesClient search method result contains all the needed data' do
    assert_instance_of Hash, @result,
      "MoviesClient search method result isn't a Hash object"
    assert @result[:movies].length == 20 && @result[:movies].first.is_a?(Movie),
      "MoviesClient search method result doesn't contains an array of Movie"
    assert_instance_of SearchQuery, @result[:search_query],
     "MoviesClient search method result doesn't contains a SearchQuery"
  end

  test 'MoviesClient search method result raise exception' do
    result = MoviesClient.search('wild', 300)
    assert_equal 'Page number is too big.', result[:alert]
  end
end
