require "spec_helper"

describe Category do
  it "saves itself" do
    cat = Category.create(name: "A test category")
    expect(Category.first).to eq(cat)
  end

  it "has many videos" do
    cat = Category.create(name: "Another test category")
    show1 = Video.create(title: "The first show", description: "This is the first show's description", categories: [cat])
    show2 = Video.create(title: "A show", description: "This is A show's description", categories: [cat])
    expect(cat.videos).to eq([show2, show1])  
  end
end