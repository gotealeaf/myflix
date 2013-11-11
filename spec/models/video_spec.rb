require 'spec_helper'

describe Video do
it "saves itself" do
  video = Video.new(title:'mark', description:'amazing', small_cover_url:'test', large_cover_url:'test',category_id:'1')
  video.save
  Video.first.title.should == 'mark'
  end


it "belongs to category" do
  dramas = Category.create(name:'dramas')
  monk = Video.create(title:'Monk', description:'About an OCD detective', category: dramas)
  expect(monk.category).to eq(dramas)
    end

  
it "does not save a video without a title" do
  video = Video.create(description: "A great video")
  expect(Video.count).to eq(0)
end



it "does not save a video without a description" do
  video = Video.create(title:"Out of the Silent Planet")
  expect(Video.count).to eq(0)
end
end



