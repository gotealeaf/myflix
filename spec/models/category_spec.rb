require 'spec_helper'

describe Category do
  it 'should save itself' do
    category = Category.new(name: 'Comedies')
    category.save
    expect(Category.first).to eq(category)
  end

  it 'should have many videos' do
    comedy = Category.create(name: 'Comedies')
    video1 = Video.create(title: 'South Park', description: 'funny stuff', category: comedy)
    video2 = Video.create(title: 'Monk', description: 'Never seen it', category: comedy)
    expect(comedy.videos).to eq([video2, video1])
  end
end
