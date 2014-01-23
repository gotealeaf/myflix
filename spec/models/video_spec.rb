require 'spec_helper'

describe Video do
  it 'saves a video' do
    video = Video.new(title: 'A video', description: 'A really long description')
    video.save
    Video.first.title.should == 'A video'
  end

  it 'can belong to a category' do
    drama = Category.create(name: 'drama')
    video = Video.create(title: 'A video', description: 'A really long description', category: drama)
    expect(Video.first.category).to eq(drama)
  end
end
