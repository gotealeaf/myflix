require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: 'Cheers', description: 'Boston Bar Life')
    video.save
    expect(Video.first).to eq(video)
  end
end
  