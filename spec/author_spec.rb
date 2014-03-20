require 'spec_reader'

describe 'Author' do
  it 'is initialized with a name' do
    test_author = Author.new('Sam Jones')
    test_author.should be_an_instance_of Author
  end

  it 'starts with an empty array' do
    test_author = Author.new('Sam Jones')
    test_author.save
    Author.all.should eq [test_author]
  end

  it 'adds multiple authors to the array' do
    test_author1 = Author.new('Sam Jones')
    test_author1.save
    test_author2 = Author.new('Bob Smith')
    test_author2.save
    Author.all.should eq [test_author1, test_author2]
  end

  describe '==(another_name)' do
    it 'should be the same author if they share the same name' do
      test_author = Author.new('Sam Jones', 2)
      test_author2 = Author.new('Sam Jones', 2)
      test_author.should eq test_author2
    end
  end
end
