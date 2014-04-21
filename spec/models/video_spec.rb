require 'spec_helper'

describe Video do
  it "saves itself" do
  	video = Video.new(title: "Game of Thrones", description: "Fantasy", large_cover_url: 'large_url.jpg', small_cover_url: 'small.jpg')
  	video.save
  	expect(Video.first).to eq(video)
  end

end