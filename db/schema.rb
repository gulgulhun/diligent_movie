# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_28_120544) do
  create_table "movies", force: :cascade do |t|
    t.integer "tmdb_id"
    t.string "title"
    t.date "release_date"
    t.float "score"
    t.string "img_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true
  end

  create_table "movies_search_queries", id: false, force: :cascade do |t|
    t.integer "movie_id"
    t.integer "search_query_id"
    t.index ["movie_id"], name: "index_movies_search_queries_on_movie_id"
    t.index ["search_query_id"], name: "index_movies_search_queries_on_search_query_id"
  end

  create_table "search_queries", force: :cascade do |t|
    t.string "query"
    t.integer "page"
    t.integer "total_pages"
    t.integer "cache_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
