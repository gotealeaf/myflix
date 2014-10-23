require 'spec_helper'

describe Category do 
  it "saves itself" do
    cat = Category.new(name: "Comedy")
    cat.save 
    expect(Category.first).to eq(cat)
  end

  it "has many videos" do 
    comedy = Category.create(name: "Comedy")
        
    vid1 = Video.create(
            title: "Comedy1", 
            description: "Follow the adventures of an endearingly ignorant dad, PETER GRIFFIN, and his hilariously odd family.",
            small_cover_url: "/tmp/family_guy.jpg",
            large_cover_url: "/tmp/family_guy.jpg",
            category: comedy
            )
    vid2 = Video.create(
            title: "Comedy2", 
            description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhou.",
            small_cover_url: "/tmp/monk.jpg",
            large_cover_url: "/tmp/monk_large.jpg",
            category: comedy
            )
    
    expect(comedy.videos).to eq([vid1, vid2])
  end
end

