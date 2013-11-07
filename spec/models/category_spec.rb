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
	
		# Line below enforces order of records (check model for 'order: :title' key/value)	
#		expect(comedies.videos). to eq([futurama, south_park])
#	end
#end

describe Category do 
	it { should have_many(:videos)}
end
	
