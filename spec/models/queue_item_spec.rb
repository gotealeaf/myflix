require 'rails_helper'

describe QueueItem do
	it {should belong_to(:user)}
	it {should belong_to(:video)}

	describe "#video_title" do
		it 'returns the title of the associated video' do
			video = Fabricate(:video, title: "Vikings")
			queue_item = Fabricate(:queue_item, video: video)
			expect(queue_item.video_title).to eq('Vikings')
		end
	end

	describe '#rating' do
		it 'returns the rating from the review when the review is present' do
			video = Fabricate(:video)
			user = Fabricate(:user)
			review = Fabricate(:review, user: user, video: video, rating: 4)
			queue_item = Fabricate(:queue_item, user: user, video: video)
			expect(queue_item.rating).to eq(4)
		end
		it 'returns nil if the review is not present' do
			video = Fabricate(:video)
			user = Fabricate(:user)
			queue_item = Fabricate(:queue_item, user: user, video: video)
			expect(queue_item.rating).to eq(nil)
		end
	end

	describe '#category_name' do
		it 'returns the category name from the video' do
			category = Fabricate(:category, name: "History Based Series")
			video = Fabricate(:video, category: category)
			queue_item = Fabricate(:queue_item, video: video)
			expect(queue_item.category_name).to eq("History Based Series")
		end
	end

	describe '#category' do
		it 'returns the category of the video' do
			category = Fabricate(:category, name: "History Based Series")
			video = Fabricate(:video, category: category)
			queue_item = Fabricate(:queue_item, video: video)
			expect(queue_item.category).to eq(category)
		end
	end


end