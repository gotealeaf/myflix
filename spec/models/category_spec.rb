require 'spec_helper'
	
#describe Category do
#	# Create a category and save it as the first record
#	it "saves itself" do
#		category = Category.new(name: "Comedies")
#		category.save

		# Check if category saved correctly
#		expect(Category.first).to eq(category)
#	end		

#	it "has many videos" do
#		# Create a category and videos
#		comedies = Category.create(name: "Comedies")
#		south_park = Video.create(name: "South Park", description: "Funny Video!!", category: comedies)
#		futurama = Video.create(name: "Futurama", description: "Another good one!", category: comedies)

		# Check to see if comedies include the videos specified
		# Line below does not care about order of records
		#expect(comedies.videos).to include(south_park, futurama)
	
		# Line below enforces order of records (check model for 'order: :name' key/value)	
#		expect(comedies.videos). to eq([futurama, south_park])
#	end
#end

describe Category do 
	it { should have_many(:videos)}

	describe "#recent_videos" do
		it "returns the videos in the reverse chronical order by created at" do
			comedies = Category.create(name: "comedies")
			futurama = Video.create(name: "Futurama", description: "space travel!", category: comedies, created_at: 1.day.ago)
			south_park = Video.create(name: "South Park", description: "crazy kids!", category: comedies)
			expect(comedies.recent_videos).to eq([south_park, futurama])
		end
		it "returns all the videos if there are less than 6 videos" do
			comedies = Category.create(name: "comedies")
			futurama = Video.create(name: "Futurama", description: "space travel!", category: comedies, created_at: 1.day.ago)
			south_park = Video.create(name: "South Park", description: "crazy kids!", category: comedies)
			expect(comedies.recent_videos.count).to eq(2)
		end
		it "returns 6 videos if there are more than 6 videos" do
			comedies = Category.create(name: "comedies")
			7.times { Video.create(name: "foo", description: "blah", category: comedies) }
			expect(comedies.recent_videos.count).to eq(6)
		end
		it "returns the most recent 6 videos" do
			comedies = Category.create(name: "comedies")
			6.times { Video.create(name: "foo", description: "blah", category: comedies) }
			tonights_show = Video.create(name: "Tonights Show", description: "talk show", category: comedies, created_at: 1.day.ago)
			expect(comedies.recent_videos).not_to include(tonights_show)
		end
		it "returns an empty array if the category does not have any videos" do
			comedies = Category.create(name: "comedies")
			expect(comedies.recent_videos).to eq([])
		end
	end
end
	
