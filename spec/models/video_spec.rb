require 'spec_helper'

describe Video do 
  it "saves itself" do 
    video = Video.new(
                    title: "Family Guy", 
                    description: "Follow the adventures of an endearingly ignorant dad, PETER GRIFFIN, and his hilariously odd family.",
                    small_cover_url: "/tmp/family_guy.jpg"
                    )
    video.save
    expect(Video.first).to eq(video)
  end
end

