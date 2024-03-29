require 'faker'

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
    @length = Faker::Number.between(from: 1, to: 9)
    @width = Faker::Number.between(from: 20, to: 30).round(1)
    @depth = Faker::Number.between(from: 11, to: 18).round(1)
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
    @isbn = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 10)}"
    @weight = Faker::Number.between(from:201, to: 800)
    @language = Faker::Nation.language
    @authorList = authors
    @publisher = Faker::Book.publisher
    @edition = Faker::Number.between(from: 1, to: 10)
    @year = Faker::Number.between( from: 2020, to: 2021)
    @month  =  Faker::Number.between( from: 1, to: 12)
    @dimensions = dim
    @rating = "#{Faker::Number.between(from:1, to:4)}.#{Faker::Number.between(from:1, to:9)}"
    @stock = Faker::Number.between( from: 1, to: 100000)
    @tagList = tags
  end

  def to_hash
    {
      title: title, 
      format: format, 
      pages: pages, 
      "isbn-13": isbn,
      weight: weight,
      language: language,
      authors: authorList,
      publisher: publisher,
      edition: edition,
      year: 2021,
      month: month,
      dimensions: dimensions,
      rating: rating,
      stock: stock,
      tags: tagList
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