require 'spec_helper'

describe Category do
	it {should have_many(:videoes)}

	describe "#show recent videos" do
		it "if more than 6, show 1st 6" do
			category = Category.create(name:"Comedy")
			a1 = Video.create(title:"South Park 1", description:"Funny show", category: category, created_at: 1.day.ago)
			a2 = Video.create(title:"South Park 2", description:"Funny show", category: category, created_at: 2.day.ago)
			a3 = Video.create(title:"South Park 3", description:"Funny show", category: category, created_at: 3.day.ago)
			a4 = Video.create(title:"South Park 4", description:"Funny show", category: category, created_at: 4.day.ago)
			a5 = Video.create(title:"South Park 5", description:"Funny show", category: category, created_at: 5.day.ago)
			a6 = Video.create(title:"South Park 6", description:"Funny show", category: category, created_at: 6.day.ago)
			a7 = Video.create(title:"South Park 7", description:"Funny show", category: category, created_at: 7.day.ago)
			expect(category.recent_videos).to eq([a1, a2, a3, a4, a5, a6])
		end

		it "if none, show blank" do
			category = Category.create(name:"Comedy")
			expect(category.recent_videos).to eq([])
		end

		it "if less than 6, show all" do
			category = Category.create(name:"Comedy")
			Video.create(title:"South Park 1", description:"Funny show", category: category)
			Video.create(title:"South Park 2", description:"Funny show", category: category)
			Video.create(title:"South Park 3", description:"Funny show", category: category)
			Video.create(title:"South Park 4", description:"Funny show", category: category)
			expect(category.recent_videos).to eq(Video.all)
		end
	end
end