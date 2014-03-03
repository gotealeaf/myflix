require 'spec_helper'

describe Video do 
  it "saves itself" do                      #THERE ARE THREE STEPS TO WRITE A TEST
    video = Video.new(title: "xyz", description: "more xyz", small_cover_url: "test short",
      large_cover_url: "test large cover")  #setup or stage the test data
    video.save                              #perform action
    expect(Video.first).to eq(video)       #verify the result

  end
  
end