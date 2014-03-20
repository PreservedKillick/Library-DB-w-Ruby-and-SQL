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
    self.title == another_book.title && self.id == another_book.id
  end

end
