require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "Chase movies")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(name: "Funny movies")
    video1 = Video.create(title: "Funny", description: "It's strange & funny!", category: comedies)
    video2 = Video.create(title: "Wacky", description: "It's wacky & strange!", category: comedies)
    expect(comedies.videos).to eq([video1, video2]) # when category.rb has has_many :videos, ->{ order(:title) }

    # expect(comedies.videos).to include(video1, video2)
      # 'include' means it has these elements in comedies.videos
      # this is not asserting any particular order

    # category = Category.new(name: "Funny movies") # or '.create'
    # video1 = Video.new(title: "Funny", description: "It's strange & funny!")
    # video1.save
    # video2 = Video.new(title: "Wacky", description: "It's wacky & strange!")
    # video2.save
    # video1.category = category
    # video1.save
    # video2.category = category
    # video2.save
    # expect(category.videos.first).to eq(video1)
    # expect(category.videos.last).to eq(video2)
  end

end