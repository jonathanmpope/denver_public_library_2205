require './lib/book'
require './lib/author'
require './lib/library'
require 'pry'

RSpec.describe do
  before :each do
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @professor = @charlotte_bronte.write("The Professor", "1857")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  it 'is an instance of' do
    expect(@dpl).to be_instance_of Library
  end

  it 'has a name' do
    expect(@dpl.name).to eq("Denver Public Library")
  end

  it 'has a collection of books' do
    expect(@dpl.books).to eq([])
  end

  it 'has a collection of authors' do
    expect(@dpl.authors).to eq([])
  end

  it 'has an add author method' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    expect(@dpl.authors).to eq([@charlotte_bronte, @harper_lee])
  end

  it 'has can access books by the authors' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    expect(@dpl.books).to eq([@jane_eyre, @professor, @villette, @mockingbird])
  end

  it 'has can access book publication time range' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    expect(@dpl.publication_time_frame_for(@charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})
    expect(@dpl.publication_time_frame_for(@harper_lee)).to eq({:start=>"1960", :end=>"1960"})
  end

  it 'can checkout books' do
    expect(@dpl.checkout(@jane_eyre)).to eq(false)
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    expect(@dpl.checkout(@jane_eyre)).to eq(true)
  end

  it 'can show checked out books' do
    expect(@dpl.checked_out_books).to eq([])
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    @dpl.checkout(@jane_eyre)
    @dpl.checkout(@villette)
    expect(@dpl.checked_out_books).to eq([@jane_eyre, @villette])
  end

  it 'can return books' do
    expect(@dpl.checked_out_books).to eq([])
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    @dpl.checkout(@jane_eyre)
    expect(@dpl.checked_out_books).to eq([@jane_eyre])
    @dpl.return(@jane_eyre)
    expect(@dpl.checked_out_books).to eq([])
    @dpl.checkout(@jane_eyre)
    @dpl.checkout(@villette)
    expect(@dpl.checkout(@villette)).to eq(false)
  end

end
