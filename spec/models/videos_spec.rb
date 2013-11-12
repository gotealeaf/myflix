require 'spec_helper'

#describe Video do
  #  Create a new record and save it, which will save it as the first record
  #it "saves itself" do
  #  video = Video.new(name: "Family Guy", description: "The funniest cartoon ever", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg", category_id: 1)
  #	 video.save
  #
  #  Compare the new record we created with the first record in the Video table
  #  expect(Video.first).to eq(video)
  #end

	#it "belongs to category" do
	#	 dramas = Category.create(name: "dramas")
	#	 monk = Video.create(name: "Monk", description: "Awesomeness", small_cover_url: "blah", large_cover_url: "blah", category: dramas)
	#	 expect(monk.category).to eq(dramas)
	#end

	#it "does not save a video wtihout a name" do
	#	 # Create a video without a name, then check the video count which should be 0
	#	 video = Video.create(description: "a great video!")
	#	 expect(Video.count).to eq(0)
	#end

	#it "does not save a video without a description" do
	#	 # Create a video without a description, then check the video count which should be 0
	#	 video = Video.create(name: "Monk")
	#	 expect(Video.count).to eq(0)
	#end
#end

describe Video do
	# Use shoulda matchers to validate Video relationship and required parameters
	it { should belong_to(:category)}
	it { should validate_presence_of(:name)}
	it { should validate_presence_of(:description)}

	describe "search_by_name" do
		it "returns an empty array if there is no match" do
			futurama = Video.create(name: "Futurama", description: "Space Travel!")
			back_to_future = Video.create(name: "Back to Future", description: "Time Travel!")
			expect(Video.search_by_name("hello")).to eq([])
		end
		it "returns an array of one video for an exact match" do
			futurama = Video.create(name: "Futurama", description: "Space Travel!")
			back_to_future = Video.create(name: "Back to Future", description: "Time Travel!")
			expect(Video.search_by_name("Futurama")).to eq([futurama])
		end	
		it "returns an array of one video for a partial match" do
			futurama = Video.create(name: "Futurama", description: "Space Travel!")
			back_to_future = Video.create(name: "Back to Future", description: "Time Travel!")
			expect(Video.search_by_name("urama")).to eq([futurama])
		end
		it "returns an array of all matches ordered by created_at" do
			futurama = Video.create(name: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
			back_to_future = Video.create(name: "Back to Future", description: "Time Travel!")
			expect(Video.search_by_name("Futur")).to eq([back_to_future, futurama])
		end
		it "returns an empty array for a search with an empty string" do
			futurama = Video.create(name: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
			back_to_future = Video.create(name: "Back to Future", description: "Time Travel!")
			expect(Video.search_by_name("")).to eq([])
		end
	end	
end
