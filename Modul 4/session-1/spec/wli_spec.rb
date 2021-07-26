require_relative "../src/wli"

RSpec.describe WLI do
  
  it 'two like' do
    #given
    wli = WLI.new
    wli.names = ["Jacob", "Alex"]

    #when
    likes= wli.likes

    #then
    expect(likes).to eq("Jacob and Alex like this")
  end

  it 'three like' do
    #given
    wli = WLI.new
    wli.names = ["Max", "John", "Mark"]

    #when
    likes= wli.likes

    #then
    expect(likes).to eq("Max, John and Mark like this")
  end

  it 'no like' do
    wli = WLI.new
    
    likes = wli.likes

    expect(likes).to eq("no one likes this")
  end

  it 'one like' do
    wli = WLI.new
    wli.names = ["Peter"]

    likes = wli.likes
    expect(likes).to eq("Peter likes this")
  end
  
  it 'many like' do
    wli = WLI.new
    wli.names = ["Alex", "Jacob", "Mark", "Max"]

    likes= wli.likes

    expect(likes).to eq("Alex, Jacob and 2 others like this")
  end

end