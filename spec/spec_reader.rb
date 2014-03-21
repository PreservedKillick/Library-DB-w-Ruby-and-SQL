require 'rspec'
require 'pg'
require 'author'
require 'book'
require 'copies'
require 'catalog'
require 'pry'

DB = PG.connect(:dbname => 'library_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM copies *;")
    DB.exec("DELETE FROM catalog *;")
  end
end
