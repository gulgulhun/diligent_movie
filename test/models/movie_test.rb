require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test 'should save movie with correct data' do
    movie = Movie.new(
      tmdb_id: 987,
      title: 'Test',
      release_date: Date.today,
      score: 10,
      img_path: nil,
      search_queries: [search_queries(:one)]
    )
    assert movie.save, 'Can not save Movie with correct data'
  end

  test 'should not save movie with existing tmdb_id' do
    Movie.create(tmdb_id: 123)
    movie = Movie.new(tmdb_id: 123)
    assert_not movie.save, 'Saved the movie with existing tmdb_id'
  end
end
