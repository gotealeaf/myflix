require 'spec_helper'

describe Video do
  it 'saves a video' do
    video = Video.new(title: 'A video', description: 'A really long description')
    video.save
    Video.first.title.should == 'A video'
  end
end
