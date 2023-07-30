# frozen_string_literal: true

# Movie model
class Movie < ApplicationRecord
  has_and_belongs_to_many :search_queries

  validates :tmdb_id,  uniqueness: true
end
