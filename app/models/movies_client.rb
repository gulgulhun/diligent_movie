# frozen_string_literal: true

require 'uri'
require 'net/http'

# This class responsible to process movies list
class MoviesClient
  include ActiveModel::Model

  def self.search(query, page = 1)
    params = "language=en-US&query=#{query}&page=#{page}"
    url = URI("https://api.themoviedb.org/3/search/movie?#{params}")

    begin
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      request['Authorization'] = ENV['TMDB_TOKEN']

      response = http.request(request)
      response_body = JSON.parse(response.read_body)

      if response.code.to_i != 200
        raise "HTTP request failed with code #{response.code}: #{response.message}"
      end
      raise 'Page number is too big.' if response_body['total_pages'] < page

      movies = Movie.where(tmdb_id: update_or_create_movies(response_body))
      search_query = SearchQuery.create(
        query: query,
        page: page,
        total_pages: response_body['total_pages'],
        cache_count: 0,
        movies: movies
      )

      return { movies: movies, search_query: search_query }
    rescue StandardError => e
      return { movies: [], search_query: search_query.presence, alert: e.message}
    end
  end

  private

  def self.update_or_create_movies(response_body)
    movies = response_body['results'].map do |result|
      {
        tmdb_id: result['id'],
        title: result['title'],
        release_date: result['release_date'],
        score: result['vote_average'],
        img_path: result['poster_path'],
      }
    end
    Movie.upsert_all(movies, unique_by: :tmdb_id)

    return  movies.map{ |m| m[:tmdb_id] }
  end
end
