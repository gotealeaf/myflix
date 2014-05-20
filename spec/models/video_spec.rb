require 'rails_helper'

describe Video do
  
  it "should persist a video to the data store" do
    video = Video.new(title:'Aliens',
                      description:'Best sci-fi movie ever!',
                      small_cover_url:'http://placehold.it/166x236',
                      large_cover_url:'http://placehold.it/665x375')
    video.save
    Video.first.title.should eq('Aliens')
  end
  
end