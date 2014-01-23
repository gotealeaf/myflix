require 'spec_helper'

describe Category do
  it 'saves itself' do
    category = Category.new(name: 'drama')
    category.save
    expect(Category.first).to eq(category)
  end

  it 'can have many videos' do
    drama = Category.create(name: 'drama')
    Video.create(title: 'First video', description: 'Hilarious!', category: drama)
    Video.create(title: 'Second video', description: 'So sad :-(', category: drama)
    expect(drama.videos.count).to eq(2)
  end
end
