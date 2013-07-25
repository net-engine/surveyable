# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130725060747) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.integer  "position"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "score"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
  end

  create_table "questions", :force => true do |t|
    t.string   "content"
    t.integer  "survey_id"
    t.string   "field_type"
    t.boolean  "required",   :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "position"
    t.integer  "minimum"
    t.integer  "maximum"
  end

  add_index "questions", ["survey_id"], :name => "index_questions_on_survey_id"

  create_table "response_answers", :force => true do |t|
    t.integer  "response_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.text     "free_content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "response_answers", ["answer_id"], :name => "index_response_answers_on_answer_id"
  add_index "response_answers", ["question_id"], :name => "index_response_answers_on_question_id"
  add_index "response_answers", ["response_id"], :name => "index_response_answers_on_response_id"

  create_table "responses", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "respondable_id"
    t.string   "respondable_type"
    t.datetime "completed_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "access_token"
    t.string   "respondent_type"
    t.string   "respondent_id"
  end

  add_index "responses", ["survey_id"], :name => "index_responses_on_survey_id"

  create_table "surveys", :force => true do |t|
    t.string   "title"
    t.boolean  "enabled",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
