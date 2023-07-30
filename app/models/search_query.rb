# frozen_string_literal: true

# SearchQuery model
class SearchQuery < ApplicationRecord
  has_and_belongs_to_many :movies

  def increment_cache_count
    update(cache_count: cache_count + 1)
  end
end
