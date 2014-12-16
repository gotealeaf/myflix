require 'rails_helper'

describe Category do
  it 'should save itself' do
    sifi = Category.create(name: 'Sicence Fiction')
    expect(Category.first).to eq(sifi)
  end

  it 'should have many videos' do
    sifi = Category.create(name: 'Sicence Fiction')
    intelerstar = Video.create(title: 'intelerstar', description: 'interesting', categories: [sifi])
    et = Video.create(title: 'endt', description: 'not interesting', categories: [sifi])
    expect(sifi.videos).to eq([et, intelerstar])
  end
end