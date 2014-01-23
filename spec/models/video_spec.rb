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

  it 'requires a title' do
    video = Video.new(description: 'Oscar-nominated Joe Mama leads this action packed blockbuster!')
    video.save
    expect(video.errors.full_messages.first).to eq("Title can't be blank")
  end

  it 'requires a description' do
    video = Video.new(title: 'Bones')
    video.save
    expect(video.errors.full_messages.first).to eq("Description can't be blank")
  end
end
