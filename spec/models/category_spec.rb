require 'spec_helper'

describe Category do
  it 'can have many videos' do
    drama = Category.create(name: 'drama')
    Video.create(title: 'First video', category: drama)
    Video.create(title: 'Second video', category: drama)
    expect(drama.videos.count).to eq(2)
  end
end
