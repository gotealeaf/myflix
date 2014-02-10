require 'spec_helper'

describe Category do
	it { should have_many(:videos) }
	it { should validate_presence_of(:name) }

	describe "#recent_videos" do
		it "returns the videos in the reverse chonical order by created at" do
			comedies = Category.create(name: "Comedies")
			yes_man = Video.create(title: "Yes Man", description: "amused movie", category: comedies)
			the_mask = Video.create(title: "The Mask", description: "funny movie", category: comedies, created_at: 1.day.ago)
			expect(comedies.recent_videos).to eq([yes_man, the_mask])
		end

		it "returns all the videos if there are less than 6 videos" do
			comedies = Category.create(name: "Comedies")
			yes_man = Video.create(title: "Yes Man", description: "amused movie", category: comedies)
			the_mask = Video.create(title: "The Mask", description: "funny movie", category: comedies, created_at: 1.day.ago)
			expect(comedies.recent_videos.count).to eq(2)
		end

		it "returns 6 videos if there are more than 6 videos" do
			comedies = Category.create(name: "Comedies")
			7.times{ Video.create(title: "Yes Man", description: "amused movie", category: comedies)}
			expect(comedies.recent_videos.count).to eq(6)
		end

		it "returns the most recent 6 videos" do
			comedies = Category.create(name: "Comedies")
			6.times{ Video.create(title: "Yes Man", description: "amused movie", category: comedies)}
			the_mask = Video.create(title: "The Mask", description: "funny movie", category: comedies, created_at: 1.day.ago)
			expect(comedies.recent_videos).not_to include(the_mask)
		end

		it "returns an empty array if the category doesn't have any videos" do
			comedies = Category.create(name: "Comedies")
			expect(comedies.recent_videos).to eq([])
		end
	end
end
