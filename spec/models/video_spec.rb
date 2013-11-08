require 'spec_helper'

describe Video do
it "saves itself" do
  video = Video.new(title:'mark', description:'amazing', small_cover_url:'test', large_cover_url:'test',category_id:'1')
  video.save
  Video.first.title.should == 'mark'
  end
end