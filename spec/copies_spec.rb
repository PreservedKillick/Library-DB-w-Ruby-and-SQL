require 'spec_reader'

describe 'Copy' do
  it 'is initialized with book and author ids' do
    test_copy = Copy.new(2, 4, 3)
    test_copy.should be_an_instance_of Copy
  end

  it "starts with an empty array" do
    test_copy = Copy.new(2, 4, 3)
    test_copy.save
    Copy.all.should eq [test_copy]
  end

  it 'adds mutliple book-author pairs to the array' do
    test_copy1 = Copy.new(2, 4, 3)
    test_copy1.save
    test_copy2 = Copy.new(4, 3, 1)
    test_copy2.save
    Copy.all.should eq [test_copy1, test_copy2]
  end

  describe '==(another_copy)' do
    it "should be the same copy if they have the same title id, author id, and id" do
      test_copy1 = Copy.new(2, 3, 4)
      test_copy2 = Copy.new(2, 3, 4)
      test_copy1.should eq test_copy2
    end
  end
end
