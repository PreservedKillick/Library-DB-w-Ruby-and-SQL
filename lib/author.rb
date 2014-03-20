class Author
  attr_reader :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM authors;")
    authors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      authors << Author.new(name, id)
    end
    authors
  end

  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_author)
    self.name == another_author.name && self.id == another_author.id
  end

end
