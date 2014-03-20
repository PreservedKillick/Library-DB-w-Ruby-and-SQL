class Copy
  attr_reader :author_id, :book_id, :id

  def initialize(author_id, book_id, id=nil)
    @author_id = author_id
    @book_id = book_id
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM copies;")
    copies = []
    results.each do |result|
      author_id = result['author_id'].to_i
      book_id = result['book_id'].to_i
      id = result['id'].to_i
      copies << Copy.new(author_id, book_id, id)
    end
    copies
  end

  def save
    results = DB.exec("INSERT INTO copies (author_id, book_id) VALUES ('#{@author_id}', '#{@book_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_copy)
    self.author_id == another_copy.author_id && self.book_id == another_copy.book_id && self.id == another_copy.id
  end
end
