require 'spec_helper'

describe Video do
	it "saves itself" do
		video = Video.new(title: "terminator", description: "sci-fi movie")
		video.save
		expect(Video.first).to eq(video)
	end

	it "belongs to category" do
		dramas = Category.create(name: "Dramas")
		inception = Video.create(title: "Inception", description: "brilliant movie", category: dramas)
		expect(inception.category).to eq(dramas)
	end
end