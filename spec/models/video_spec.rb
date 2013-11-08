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

  describe "search_by_title" do
      it "returns an empty array if there is no match" do
        video1 = Video.create(title: "Hello Kitty", description: "Hello hello Kitty!")
        video2 = Video.create(title: "Superman", description: "Super super superman")
        expect(Video.search_by_title("spiderman")).to eq([])
      end

      it "returns an array of one video for an exact match" do
        video1 = Video.create(title: "Hello Kitty", description: "Hello hello Kitty!")
        video2 = Video.create(title: "Superman", description: "Super super superman")
        expect(Video.search_by_title("Superman")).to eq([video2])
      end

      it "returns an array of one video for a partial match" do
        video1 = Video.create(title: "Hello Kitty", description: "Hello hello Kitty!")
        video2 = Video.create(title: "Superman", description: "Super super superman")
        expect(Video.search_by_title("kit")).to eq([video1])
      end

      it "returns an array of all matches ordered by created_at" do
        video1 = Video.create(title: "Hello Super Kitty", description: "Hello hello Kitty!")
        video2 = Video.create(title: "Superman", description: "Super super superman", created_at: 2.days.ago)
        expect(Video.search_by_title("Super")).to eq([video1, video2])
      end
    end
end