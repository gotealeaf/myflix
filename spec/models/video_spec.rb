require 'spec_helper'

describe Video do
	it "saves itself" do
		video = Video.new(title: "terminator", description: "sci-fi movie")
		video.save
		expect(Video.first).to eq(video)
	end
end