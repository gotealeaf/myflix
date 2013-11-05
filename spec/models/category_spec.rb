require 'spec_helper'

describe Category do
  # it 'save itself' do
  #   category = Category.new(name: "Movie")   
  #   category.save
  #   expect(Category.first.name).to eq("Movie") 
  # end

  # it "has many videos" do
  #   category = Category.new(name: "Movie")   
  #   category.save
  #   video1 = Video.new(title: "Bones test", description: 'Test informations', small_cover_url: '/img/bones_small.jpg', large_cover_url: '/img/bones_large.jpg', category_id: 1)
  #   video1.save
  #   video2 = Video.new(title: "Another Bones", description: 'Test informations 2', small_cover_url: '/img/bones_small2.jpg', large_cover_url: '/img/bones_large2.jpg', category_id: 1)
  #   video2.save
  #   category.videos.size.should == 2
  #   expect(category.videos).to eq([video2, video1])
  # end

  # it "is invalid if has a same name" do
  #   Category.create(name: "Animation")
  #   expect(Category.create(name: "Animation")).to have(1).errors_on(:name)  
  # end
  #
  #
  # rewrite using shoulda matchers

  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}
end