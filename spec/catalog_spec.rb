require 'spec_reader'

describe 'Catalog' do
  it 'is initialized with book and author ids' do
    test_catalog = Catalog.new(2, 4, 3)
    test_catalog.should be_an_instance_of Catalog
  end

  it "starts with an empty array" do
    test_catalog = Catalog.new(2, 4, 3)
    test_catalog.save
    Catalog.all.should eq [test_catalog]
  end

  it 'adds mutliple book-author pairs to the array' do
    test_catalog1 = Catalog.new(2, 4, 3)
    test_catalog1.save
    test_catalog2 = Catalog.new(4, 3, 1)
    test_catalog2.save
    Catalog.all.should eq [test_catalog1, test_catalog2]
  end

  describe '==(another_catalog)' do
    it "should be the same catalog if they have the same title id, author id, and id" do
      test_catalog1 = Catalog.new(2, 3, 4)
      test_catalog2 = Catalog.new(2, 3, 4)
      test_catalog1.should eq test_catalog2
    end
  end
end
