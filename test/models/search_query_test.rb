require "test_helper"

class SearchQueryTest < ActiveSupport::TestCase
  test 'should save SearchQuery with correct data' do
    sq = SearchQuery.new(
      query: 'test',
      page: 1,
      total_pages: 1,
      cache_count: 0,
      movies: [movies(:movie_0), movies(:movie_1)]
    )
    assert sq.save, 'Can not save SearchQuery with correct data'
  end

  test 'search_query cache_count should increment by 1' do
    search_queries(:one).increment_cache_count
    assert_equal(1, search_queries(:one).cache_count,
                 'search_query cache_count was not incremented')
  end
end
