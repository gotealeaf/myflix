require 'spec_helper'

describe Video do
  it 'saves a video' do
    video = Video.new(title: 'A video', description: 'A really long description')
    video.save
    Video.first.title.should == 'A video'
  end

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
