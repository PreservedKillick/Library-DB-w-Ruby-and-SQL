class Copy
  attr_reader :book_id, :id

  def initialize(book_id, id=nil)
    @book_id = book_id
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM copies;")
    copies = []
    results.each do |result|
      book_id = result['book_id'].to_i
      id = result['id'].to_i
      copies << Copy.new(book_id, id)
    end
    copies
  end

  def save
    results = DB.exec("INSERT INTO copies (book_id) VALUES ('#{@book_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_copy)
    self.book_id == another_copy.book_id && self.id == another_copy.id
  end
end
