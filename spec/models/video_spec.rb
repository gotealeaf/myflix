require 'spec_helper'

describe Video do
  context "relationships" do 
    it {should belong_to(:category) } 
  end 
 
 describe "Video Vlaidations" do 
   it "It is valid with title and description" do 
     video = Video.new(title: "Monster", description: "This is one of the best movies of 1992", category_id: 1)
     video.save
     expect(Video.first).to eq(video)
   end 

   it "is invalid with no title" do 
     video = Video.new(title: nil, description: "This is one of the best movies on 1992")
     expect(video).to_not be_valid 
   end 
   
   it "is invalid with no description" do 
     video = Video.new(title: "Batman", description: "") 
     expect(video).to_not be_valid 
   end 
  end 
end
