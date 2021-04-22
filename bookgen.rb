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

require 'faker'
require 'json'

class Author
  attr_accessor :order, :first, :last

  def initialize(order)
    @order = order
    @first = Faker::Name.first_name
    @last = Faker::Name.last_name
  end
  def to_hash
    {
      order: order,
      last: last,
      first: first
    }
  end
end

class Dimension
  attr_accessor :length, :width, :depth

  def initialize
    @length = Faker::Number.between(from: 1, to: 20)
    @width = Faker::Number.between(from: 1, to: 12).round(1)
    @depth = Faker::Number.between(from: 1, to: 12).round(1)
  end
  def to_hash
    {
      length: length,
      width: width,
      depth: depth
    }
  end
end

class Book
  attr_accessor :title, :format, :pages, :isbn, :weight, :language,
                :publisher, :edition, :year, :month, :rating, :stock, 
                :tagList, :authorList, :dimensions

  def initialize
    @title = Faker::Book.title
    @format = randomFormat
    @pages = Faker::Number.between(from:100, to: 1000)
    @isbn = Faker::Code.isbn
    @weight = Faker::Number.decimal(l_digits: 3, r_digits: 2)
    @language = Faker::Nation.language
    @publisher = Faker::Book.publisher
    @edition = Faker::Number.between(from: 1, to: 10)
    @year = Faker::Number.between( from: 1900, to: 2021)
    @month  =  Faker::Number.between( from: 1, to: 12)
    @rating = Faker::Number.between(from: 0.0, to: 5.0).round(2)
    @stock = Faker::Number.between( from: 1, to: 100000)
    @tagList = tags

    @authorList = authors
    @dimensions = dim
  end

  def to_hash
    {
      title: title, 
      format: format, 
      pages: pages, 
      isbn: isbn,
      weight: weight,
      language: language,
      publisher: publisher,
      edition: edition,
      year: year,
      month: month,
      rating: rating,
      stock: stock,
      tags: tagList,
      authors: authorList,
      dimensions: dimensions
    }
  end

  private

  def authors
    limit = Faker::Number.between( from: 1, to: 3)
    (1..limit).map {|i| Author.new(i).to_hash }
  end

  def randomFormat
    ['Paperback', 'Hardcover'][Faker::Number.between(from: 0, to: 1)]
  end

  def tags
    limit = Faker::Number.between( from: 1, to: 5)
    t = (1..limit).map {|i| Faker::Book.genre }
  end

  def dim
    Dimension.new.to_hash
  end

end

add_comma = false
print '['
100000.times do
  book = Book.new
  print ',' if add_comma
  add_comma ||= true
  print book.to_hash.to_json
end
puts "\n]"
