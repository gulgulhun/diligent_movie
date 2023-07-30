# frozen_string_literal: true

# Migration for the new movie and search query models and
# for the necessary association table
class CreateMoviesAndSearchQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.integer :tmdb_id, index: { unique: true }
      t.string :title
      t.date :release_date
      t.float :score
      t.string :img_path

      t.timestamps
    end

    create_table :search_queries do |t|
      t.string :query
      t.integer :page
      t.integer :total_pages
      t.integer :cache_count, default: 0

      t.timestamps
    end

    create_table :movies_search_queries, id: false do |t|
      t.belongs_to :movie
      t.belongs_to :search_query
    end
  end
end
