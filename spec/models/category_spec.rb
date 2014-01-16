require 'spec_helper'

describe Category do
		it "saves itself" do
    category = Category.create(title:"horror")
    category.save
    expect(Category.first.title).to eq "horror"
	end
	it {should have_many :videos}
end