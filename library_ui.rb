require 'pg'
require './lib/author'
require './lib/book'
require './lib/copies'
require './lib/catalog'
require 'pry'

DB = PG.connect({:dbname => 'library'})

system "clear"

def start_menu
  puts "Welcome to the Library System!!"
  puts "Press 'l' if you are a librarian"
  puts "Press 'p' if you are a patron"
  puts "Press 'x' to exit"

  start_input = gets.chomp.downcase
  case start_input
  when  'l'
    librarian_menu
  when 'p'
    patron_menu
  when 'x'
    system 'clear'
  else
    puts "Please enter a valid input"
    start_menu
  end
end

def librarian_menu
  system "clear"
  puts "Press 'e' to add an entry to the database"
  puts "Press 'x' to exit"

  librarian_input = gets.chomp.downcase
  case librarian_input
  when 'e'
    main_entry
  when 'x'
    system 'clear'
  else
    puts "Please enter a valid input"
    librarian_menu
  end
end

def main_entry
  system 'clear'
  puts "Please enter the title of the book you want to add to the database."
  title_input = gets.chomp.upcase
  existing_book = Book.all.select do |book|
    book.title == title_input
  end
  #creates array of a book object that has the same title

  if existing_book.length == 0
    new_book = Book.new(title_input)
    new_book.save
    puts "\n\nYou have successfully added #{title_input} to the database."
    puts "\n\nWho is the author of #{title_input}?"
    name_input = gets.chomp.upcase


    existing_author = Author.all.select do |author|
      author.name == name_input
    end
    #creates array of an author object who has the same name


    if existing_author.length == 0
      new_author = Author.new(name_input)
      new_author.save
      puts "\n\nYou have successfully added #{name_input} to the database."
      new_catalog_entry = Catalog.new(new_author.id, new_book.id)
      new_catalog_entry.save
      librarian_menu
    else
      puts "\n\n#{existing_author} already exists in the database.  We have created a new entry for #{existing_book} by #{existing_author} in the database.\n"
      new_catalog_entry = Catalog.new(existing_author[0].id, new_book.id)
      librarian_menu
    end


  else
    the_authors = existing_book[0].find_authors

    the_authors.each do |author|
      puts author.name
    end

    puts "\n\n"
    gets.chomp
    librarian_menu
  end
end

# def add_author
#   puts "\n\n\n\n"
#   puts "Please enter the author's name (First Last):\n\n"

#   name_input = gets.chomp.upcase
#   new_author = Author.new(name_input)
#   new_author.save
#   puts "\n\nYou have successfully added #{name_input} to the database."
#   puts "Press 'a' if you want to add a book by #{name_input} to the database"
#   puts "Press 'm' if you have already added books by this author to the database"
#   input = gets.chomp.downcase
#   case input
#   when 'a'
#     add_book
#   when 'm'
#     make_catalog(name_input, title_input)
#   else
#     puts "Please enter a valid input"
#     add_author
#   end
# end

# def add_book
#   puts "\n\n\n\n"
#   puts "Please enter the title of the book you want to add to the database."

#   title_input = gets.chomp.upcase
#   new_book = Book.new(title_input)
#   new_book.save
#   puts "\n\nYou have successfully added #{title_input} to the database."
#   puts "Press 'a' if you need add the author to the database"
#   puts "Press 'm' if you have already added the author"
#   input = gets.chomp.downcase
#   case input
#   when 'a'
#     add_author
#   when 'm'
#     make_catalog(name_input, title_input)
#   else
#     puts "Please enter a valid input"
#     add_book
#   end
# end

def make_catalog(name_input, title_input)
  system "clear"
  selected_author = Author.all.detect {|author| author.name == name_input}
  selected_aID = selected_author.id.to_i

  selected_book = Book.all.detect {|book| book.title == title_input}
  selected_bID = selected_book.id.to_i

  new_copy = Copy.new(selected_aID, selected_bID)
  new_copy.save
  puts "You have created a new entry for #{title_input} by #{name_input}."

end


start_menu
