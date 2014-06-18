require 'rails_helper'

describe Video do
  # it "saves itself" do 
  #   video = Video.new(title: "Highway to Rails", description: "A fast paced thriller with plenty of feel-good moments.")
  #   video.save
  #   expect(Video.first).to eq(video)
  # end

  it { should belong_to (:category) }
  # it "belongs to a category" do
  #   drama = Category.create(name: "Drama")
  #   monk = Video.create(title: "Monk", description: "Not my cup of tea, but to each his own.", category: drama)
  #   expect(monk.category).to eq(drama)
  # end

  it { should validate_presence_of (:title) }
  # it "doesn't save a video without a title" do
  #   video = Video.create(description: "I don't have a title!")
  #   expect(video.errors.any?).to eq(true)
  # end

  it { should validate_presence_of (:description) }
  # it "doesn't save a video without a description" do
  #   video = Video.create(title: "I don't have a description!")
  #   expect(Video.count).to eq(0)
  # end

  describe "search_by_title" do
    it "returns an empty array if no match" do
      matrix = Video.create(title: "Matrix", description: "Take the blue pill!")
      walking_dead = Video.create(title: "The Walking Dead", description: "AHHH!")
      expect(Video.search_by_title('test search')).to eq([])
    end

    it "returns an array of one video for an exact match" do
      matrix = Video.create(title: "Matrix", description: "Take the blue pill!")
      walking_dead = Video.create(title: "The Walking Dead", description: "AHHH!")
      expect(Video.search_by_title("Matrix")).to eq([matrix])
    end

    it "returns an array of one video for a partial match" do
      matrix = Video.create(title: "Matrix", description: "Take the blue pill!")
      walking_dead = Video.create(title: "The Walking Dead", description: "AHHH!")
      expect(Video.search_by_title("trix")).to eq([matrix])
    end

    it "returns an array of all matches ordered by created_at" do
      matrix = Video.create(title: "Matrix", description: "Take the blue pill!", created_at: 1.day.ago)
      walking_dead = Video.create(title: "The Walking Dead", description: "AHHH!")
      expect(Video.search_by_title("A")).to eq([walking_dead, matrix])
    end

    it "returns an empty array for an empty search" do
      matrix = Video.create(title: "Matrix", description: "Take the blue pill!", created_at: 1.day.ago)
      walking_dead = Video.create(title: "The Walking Dead", description: "AHHH!")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end


