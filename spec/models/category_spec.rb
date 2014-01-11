require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  it 'saves itself' do
    tv = Category.new(name: 'TV')
    tv.save
    expect(Category.first).to eq(tv)
  end

  it 'has many videos' do
    tv = Category.create(name: 'TV')
    south_park = Video.create(title:'South Park', description:'n/a', category: tv)
    futurama = Video.create(title:'Futurama', description:'n/a', category: tv)
    #expect(tv.videos).to include(one, two)
    expect(tv.videos).to eq([futurama, south_park])
  end
end
