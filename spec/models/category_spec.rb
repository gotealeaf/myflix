require 'spec_helper'

describe Category do

   it { should have_many(:videos) }

=begin
  it "saves itself" do
    category = Category.new(name: "Thrillers")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has videos" do
    thrillers = Category.create(name: "Thrillers")

    winkle = Video.create(title: "Bullwinkle", description: "Moose Story", category: thrillers)
    bodyheat = Video.create(title: "Body Heat", description: "sultry", category: thrillers)

    expect(thrillers.videos).to eq([bodyheat, winkle])
  end
=end



end
