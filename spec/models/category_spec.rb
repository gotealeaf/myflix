require 'rails_helper.rb'

describe Category do
  it "saves itself" do
    category = Category.create(name: "Comedy")
    expect(Category.last).to eq(category)
  end

  it "has many videos" do
    comedy = Category.create(name: "Comedy")
    ghostbusters = Video.create(title: "Ghostbusters", description: "Clasic comedy.", category: comedy)
    caddyshack = Video.create(title: "Caddyshack", description: "Overrated comedy.", category: comedy)
    expect(comedy.videos).to eq([caddyshack, ghostbusters])
  end

end
