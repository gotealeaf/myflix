require 'spec_helper'

describe QueueItem do 
	it {should belong_to :user}
	it {should belong_to :video}

	describe "#video_title" do
		it "should display title of queue item's video" do
			video = Fabricate(:video, title:"monk")
			queueitem = Fabricate(:queue_item, video: video)
			expect(queueitem.video_title).to eq("monk")
		end
	end

	describe "#rating" do 
		it "should display the user's rating of the video" do
			user = Fabricate(:user)
			video = Fabricate(:video)
			review = Fabricate(:review, user: user, video: video, rating: 4)
			queueitem = Fabricate(:queue_item, user: user, video: video)
			expect(queueitem.rating).to eq(4)
		end

		it "should return nil if user has not made a review" do
			user = Fabricate(:user)
			video = Fabricate(:video)
			queueitem = Fabricate(:queue_item, user: user, video: video)
			expect(queueitem.rating).to be_blank
		end
	end

	describe "#category_name" do
		it "should display the category name of the queue item's video" do 
			user = Fabricate(:user)
			category = Fabricate(:category)
			video = Fabricate(:video, category:category)
			queueitem = Fabricate(:queue_item, user: user, video: video)
			expect(queueitem.category_name).to eq(category.name)
		end
	end

	describe "#category" do
		it "should return the category of the queueitem's video" do
		  	user = Fabricate(:user)
			category = Fabricate(:category)
			video = Fabricate(:video, category:category)
			queueitem = Fabricate(:queue_item, user: user, video: video)
			expect(queueitem.category).to eq(category)
		end
	end
end