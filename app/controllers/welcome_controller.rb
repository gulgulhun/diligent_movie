# frozen_string_literal: true

# Home page controller
class WelcomeController < ApplicationController
  before_action :search_movies, only: :index

  def index
    flash.now.notice = "Cache number: #{@cache_count}" if @cache_count
  end

  private

  def search_movies
    query = params[:search]&.downcase

    return if query.blank?

    @page = (params[:page] || 1).to_i
    search_query = SearchQuery.find_by("query like ? AND page = ? AND created_at > ?",
                                        query, @page, 2.minutes.ago)

    if search_query
      search_query.increment_cache_count
      @movies = search_query.movies
    else
      result = MoviesClient.search(query, @page)

      return flash.alert = "The following error occurred: #{result[:alert]}" if result[:alert]

      @movies = result[:movies]
      search_query = result[:search_query]
    end

    @cache_count = search_query&.cache_count
    @total_pages = search_query&.total_pages
  end
end
