require 'spec_helper'

describe Video do
	it "saves itself" do
		video = Video.new(title: "test title", description: "this is only a test....")
		video.save
		expect(Video.first.title).to eq("test title")
	end	

	it "belongs to a category" do
		dramas = Category.create(name: "dramas")
		true_detective = Video.new(title: "True Detective", description: "this movie is hilarious....", category: dramas)
		expect(true_detective.category).to eq(dramas)
	end
end


