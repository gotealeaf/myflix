require "spec_helper"

describe Category do
  it "saves itself" do
    category = Category.new(name: "horror movie")
    category.save
    expect(Category.find_by name: "horror movie").to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(name: "comedies")
    funny1 = Video.create(title: "Kung Fu Panda", description: "very funny", category: comedies)
    funny2 = Video.create(title: "Shaolin Soccer", description: "Hilarious!", category: comedies)
    expect(comedies.videos).to eq([funny1, funny2])
  end
  
end