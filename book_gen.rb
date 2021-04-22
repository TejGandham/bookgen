#!/usr/bin/env ruby

# Expected format
#{
#     "title": "The Price of Admiralty: The Evolution of Naval Warfare from Trafalgar to Midway",
#     "format": "Paperback",
#     "pages": 400,
#     "isbn-13": "978-0140096507",
#     "weight": 280.66,
#     "language": "English",
#     "authors": [
#         {
#             "order": 1,
#             "first": "John",
#             "last": "Keegan",
#         },
#     ],
#     "publisher": "Pengiun Books",
#     "edition": 3,
#     "year": 1990,
#     "month": 2,
#     "dimensions": {
#         "length": 18,
#         "width": 13,
#         "depth": 2.2
#     },
#     "rating": 4.56,
#     "stock": 9801,
#     "tags": [
#         "Naval military history", "World War I", "World War II"
#     ]
# }


require 'thor'
require "./book"

class BookGen < Thor
  desc "json RECORD_COUNT FILENAME", "generate book info json"

  def json(recordCount=100, filename='books.json')
    books = []
    recordCount.to_i.times do |i|
      puts "Generated #{i+1} records" if ((i+1) % 100)  == 0
      book = Book.new
      books << book.to_hash
    end

    File.write(filename,  books.to_json)
  end

end

BookGen.start(ARGV)