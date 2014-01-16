require 'spec_helper'

describe Category do
	it "saves itself" do
		category = Category.new(name: "Comedies")
		category.save
		expect(Category.first).to eq(category)
	end

	it "has many videos" do
		comedies = Category.create(name: "comedies")
		yes_man = Video.create(title: "Yes Man", description: "funny movie", category: comedies)
		kick_ass = Video.create(title: "Kick-Ass", description: "amused movie", category: comedies)
		
		expect(comedies.videos).to eq([kick_ass, yes_man])		
	end
end