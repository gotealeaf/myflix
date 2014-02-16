require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: 'Video', description: 'description', short_image_url: '/tmp/test.jpg', large_image_url: '/tmp/test.jpg')
    video.save
    Video.first.title.should == 'Video'
    Video.first.description.should == 'description'
    Video.first.large_image_url.should == '/tmp/test.jpg'
    Video.first.short_image_url.should == '/tmp/test.jpg'
  end

  it "belongs_to Category model" do
    should belong_to(:category)
  end

  it "validates presence of :title, :description" do
    should validate_presence_of(:title)
    should validate_presence_of(:description)
  end
end
