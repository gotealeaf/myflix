require 'spec_helper'

  describe Category do
    it { should have_many(:videos) }
  end

  # it "has many videos" do
  #   video2 = Video.new(title: "Godfather II", description: "Due")
  #   video3 = Video.new(title: "Godfather III", description: "Tre")
  #   video2.save
  #   video3.save
  #   category = Category.new(name: "Mafia")
  #   category.videos << video2
  #   category.videos << video3
  #   category.save
  #   expect(category.videos.size).to eq(2)
  # end


