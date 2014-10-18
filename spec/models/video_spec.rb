require 'spec_helper'

describe Video do

	it {should belong_to(:category)}
	it {should validate_presence_of(:description)}
	it {should validate_presence_of(:title)}

	describe "search by video" do
		it "if no entry" do
			southpark = Video.create(title: "South Park", description: "funny movie")
			simpsons = Video.create(title: "Simpsons", description: "funny movie")
			expect(Video.search_by_title("No title")).to eq([])
		 end

		it "if 1 entry" do
			southpark = Video.create(title: "South Park", description: "funny movie")
			simpsons = Video.create(title: "Simpsons", description: "funny movie")
			expect(Video.search_by_title("South Park")).to eq([southpark])
		end

		it "if multiple entries" do
			southpark = Video.create(title: "South Park", description: "funny movie")
			simpsons = Video.create(title: "Simpsons", description: "funny movie", created_at: 1.day.ago)
			expect(Video.search_by_title("S")).to eq([southpark, simpsons])
		end 

		it "if search term blank" do
			southpark = Video.create(title: "South Park", description: "funny movie")
			simpsons = Video.create(title: "Simpsons", description: "funny movie")
			expect(Video.search_by_title("")).to eq([])
		end
	end

end