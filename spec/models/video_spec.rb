require 'rails_helper.rb'

describe Video do
  it "belongs to categories" do
    comedy = Category.create(name: "Comedy")
    ghostbusters = Video.create(title: "Ghostbusters", category: comedy)
    expect(ghostbusters.category).to eq(comedy)
  end

  it "does not save video without title" do
    video = Video.create(description: "About the video.")
    expect(Video.count).to eq(0)
  end

  it "does not save video without description" do
    video = Video.create(title: "Breaking Bad")
    expect(Video.count).to eq(0)
  end
end
