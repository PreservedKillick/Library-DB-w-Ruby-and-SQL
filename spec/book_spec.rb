require 'spec_reader'

describe 'Book' do
  it 'is initialized with a title' do
    test_book = Book.new('Waiting')
    test_book.should be_an_instance_of Book
  end

  it 'starts with an empty array' do
    test_book = Book.new('Waiting')
    test_book.save
    Book.all.should eq [test_book]
  end

  it 'adds multiple books to the array' do
    test_book1 = Book.new('Waiting')
    test_book1.save
    test_book2 = Book.new('Hunger Games')
    test_book2.save
    Book.all.should eq [test_book1, test_book2]
  end

  describe '==(another_name)' do
    it 'should be the same book if they share the same name' do
      test_book = Book.new('Waiting')
      test_book2 = Book.new('Waiting')
      test_book.should eq test_book2
    end
  end
end
