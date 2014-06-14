require 'rails_helper'

describe Category do
  it "saves itself" do 
    category = Category.new(name: "Hyper Action")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    hyper_action = Category.create(name: "Hyper Action")
    walking_dead = Video.create(title: "The Walking Dead", description: "Scary, becoming-lame show.", category: hyper_action)
    flash_forward = Video.create(title: "Flash Forward", description: "A one season wonder.", category: hyper_action)
    expect(hyper_action.videos).to eq([flash_forward, walking_dead])
  end
end