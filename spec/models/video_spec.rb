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

  it 'should not save a video without a title' do
    Video.create(description: 'Video without a title')
    expect(Video.count).to eq(0)
  end

  it 'should not save a video without a desciption' do
    Video.create(title: 'South Park')
    expect(Video.count).to eq(0)
  end
end

