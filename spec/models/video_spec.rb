require 'rails_helper'

describe Video do
<<<<<<< HEAD
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
=======
  it "saves itself" do
    video = Video.new(title: "monk", description: "a great video")
    video.save
    expect(Video.first).to eq(video)
  end
>>>>>>> master
end