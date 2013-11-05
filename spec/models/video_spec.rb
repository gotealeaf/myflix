require 'spec_helper'

describe Video do
  # it "save itself" do
  #   video = Video.new(title: "Bones_test", description: 'Test informations', small_cover_url: '/img/bones_small.jpg', large_cover_url: '/img/bones_large.jpg', category_id: 1)
  #   video.save
  #   Video.first.title.should == "Bones_test"
  #   Video.first.description.should == 'Test informations'
  #   Video.first.small_cover_url.should == '/img/bones_small.jpg'
  #   Video.first.large_cover_url.should == '/img/bones_large.jpg'
  #   Video.first.category_id.should ==  1
  # end

  # it "belongs to category" do
  #   video = Video.create(title: "Bones_test", description: 'Test informations', small_cover_url: '/img/bones_small.jpg', large_cover_url: '/img/bones_large.jpg', category_id: 1)
  #   category = Category.create(name: "Movie")
  #   expect(Video.first.category).to eq(category)
  # end
 
  # it "is invalid without a title" do
  #   expect(Video.new(title: nil)).to have(1).errors_on(:title)    
  # end

  # it "is invalid without a description" do
  #   expect(Video.new(description: nil)).to have(1).errors_on(:description)    
  # end

  # it "is invalid if has a same title" do
  #   Video.create(title: "Bones", description: "Great movie!")
  #   expect(Video.create(title: "Bones", description: "Fun movie!")).to have(1).errors_on(:title)  
  # end
  #
  # rewrite using shoulda matchers

  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should validate_uniqueness_of(:title)}
end