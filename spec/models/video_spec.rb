require 'rails_helper'

describe Video do
  it "saves itself" do 
    video = Video.new(title: "Highway to Rails", description: "A fast paced thriller with plenty of feel-good moments.")
    video.save
    expect(Video.first).to eq(video)
  end
end