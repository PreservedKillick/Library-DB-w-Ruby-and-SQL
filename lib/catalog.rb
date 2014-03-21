class Catalog
  attr_reader :author_id, :book_id, :id

  def initialize(author_id, book_id, id=nil)
    @author_id = author_id
    @book_id = book_id
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM catalog;")
    catalogs = []
    results.each do |result|
      author_id = result['author_id'].to_i
      book_id = result['book_id'].to_i
      id = result['id'].to_i
      catalogs << Catalog.new(author_id, book_id, id)
    end
    catalogs
  end

  def save
    results = DB.exec("INSERT INTO catalog (author_id, book_id) VALUES (#{@author_id}, #{@book_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_catalog)
    self.author_id == another_catalog.author_id && self.book_id == another_catalog.book_id && self.id == another_catalog.id
  end

end
