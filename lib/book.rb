class Book
  attr_reader :title, :id

  def initialize(title, id=nil)
    @title = title
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM books;")
    books = []
    results.each do |result|
      title = result['title']
      id = result['id'].to_i
      books << Book.new(title, id)
    end
    books
  end

  def save
    results = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_book)
    self.title == another_book.title
  end

  def find_authors
    results = DB.exec("SELECT authors.name FROM books
               JOIN catalog ON (books.id = catalog.book_id)
               JOIN authors ON (authors.id = catalog.author_id) WHERE books.id = #{self.id};")
    authors = []
    results.each do |result|
      name = result['name']
      authors << Author.new(name)
    end
    authors
  end
end
