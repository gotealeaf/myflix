require 'spec_helper'

describe Video do
  it 'should save itself' do
    video = Video.new(title: 'South Park', description: 'Funny stuff')
    video.save
    expect(Video.first).to eq(video)
  end

  it 'should belong to a category' do
    category = Category.new(name: 'Comedies')
    video = Video.new(title: 'South Park', description: 'Funny stuff', category: category)
    expect(video.category).to eq(category)
  end
end

