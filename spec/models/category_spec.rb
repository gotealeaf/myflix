require 'spec_helper'

describe Category do

  before { @drama_category = Category.new(name: "Drama") }

  it { should validate_presence_of(:name) }
  it "should validate that length of name is not too long"


  describe 'with proper-format attributes' do

    it "responds to all attributes" do
      expect(@drama_category).to respond_to(:name)
      expect(@drama_category).to respond_to(:videos)
    end

    it "orders properly" do
      @drama_category.save
      @monk = Video.create(title: "Monk",
                           description: "A forensics show.",
                           sm_cover_locn: "/tmp/monk.jpg",
                           lg_cover_locn: "/tmp/monk_large.jpg",
                           categories: [@drama_category])
      @lie_to_me = Video.create(title: "Lie To Me",
                                description: "An microexpressions tv show.",
                                sm_cover_locn: "/tmp/lie_to_me.jpg",
                                lg_cover_locn: "/tmp/lie_to_me_large.jpg",
                                categories: [@drama_category])

      expect(@drama_category.videos).to eq([@lie_to_me, @monk])
    end

    it "saves into the database exactly" do
      @drama_category.save
      expect(Category.last).to eq(@drama_category)
    end
  end

  # TDD of recent_videos method
  describe "display of most recent video additions" do
    before do
      @drama_category.save
      @monk = Video.create(title: "Monk",
                             description: "A forensics show.",
                             sm_cover_locn: "/tmp/monk.jpg",
                             lg_cover_locn: "/tmp/monk_large.jpg",
                             categories: [@drama_category])
      @monk2 = @monk.dup
      @monk2.title = "Monk2"
      @monk2.categories = [@drama_category]
      @monk2.save
    end


    it "returns empty array if there are no videos" do
      @empty_category = Category.create(name: "Empty")
      expect(Category.find_by(name: "Empty").recent_videos).to be_empty
    end
    it "returns the most recent videos in a cateogry - up to 6 videos" do
      expect(Category.find_by(name:"Drama").recent_videos).to include(@monk, @monk2)
    end
    it "will return maximum 6 recent videos" do
      i = 3
      [@monk3, @monk4, @monk5, @monk6, @monk7].each do |vid|
        vid = @monk.dup
        vid.title = "Monk+#{i}"
        i +=1
        vid.categories = [@drama_category]
        vid.save
      end
      expect(Category.find_by(name:"Drama").recent_videos.size).to eq(6)
    end
    it "returns videos in reverse chronological order (most recent first)" do
      expect(Category.find_by(name:"Drama").recent_videos).to eq([@monk2,@monk])
    end
  end
end
