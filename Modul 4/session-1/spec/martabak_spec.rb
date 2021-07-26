require_relative "../src/martabak"

RSpec.describe Martabak do 
  it 'is delicious' do
    # given
    martabak = Martabak.new("cokelat")

    # when
    taste = martabak.taste

    # then: expectasi dari object trsbt
    expect(taste).to eq("martabak cokelat is delicious")
  end

  it 'keju is delicious' do
    #given
    martabak = Martabak.new("keju")

    #when
    taste = martabak.taste

    #expect
    expect(taste).to eq("martabak keju is delicious")

  end
end
