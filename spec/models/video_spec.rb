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
end