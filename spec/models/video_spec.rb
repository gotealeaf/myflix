require 'spec_helper'

describe Video do
	it "saves itself" do
    video = Video.create(title:"horror",description: "This is the most horror movie of all time")
    video.save
    expect(Video.first.title).to eq "horror"
	end

	it { should belong_to :category}
	it { should validate_presence_of(:title)}
	it { should validate_presence_of(:description)}
end