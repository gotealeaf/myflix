require 'spec_helper'

describe Video do 
  it "saves itself" do
    video = Video.new(title: "monk", description: "a great video!")
    video.save

    expect(Video.first).to eq(video)
  end

  it { should have_many(:video_categories) }
  it { should have_many(:categories).through(:video_categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
