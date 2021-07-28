require_relative '../src/number.rb'

RSpec.describe Number do
  it 'return 562 if 561' do
    number = Number.new([5,6,1])

    result = number.increment

    expect(result).to eq([5,6,2])
  end

  it 'return 40 if 39' do
    number = Number.new([3,9])

    result = number.increment

    expect(result).to eq([4,0])
  end

  it 'return 100 if 99' do
    number = Number.new([9,9])

    result = number.increment

    expect(result).to eq([1,0,0])
  end

  it 'return 1090 if 1089' do
    number = Number.new([1,0,8,9])

    result = number.increment

    expect(result).to eq([1,0,9,0])
  end

  it 'return 999 if 1000' do
    number = Number.new([9,9,9])

    result = number.increment

    expect(result).to eq([1,0,0,0])
  end
   
  it 'return 10 if 9' do
    number = Number.new([9])

    result = number.increment

    expect(result).to eq([1,0])
  end
  it 'return 1 if 0' do
    number = Number.new([0])

    result = number.increment

    expect(result).to eq([1])
  end

   it 'return 10000000 if 9999999' do
    number = Number.new([9,9,9,9,9,9,9])

    result = number.increment

    expect(result).to eq([1,0,0,0,0,0,0,0])
  end
end