require 'spec_helper'

describe Category do
  
  it "saves itself" do
    category = Category.new(name: "Film Noir")
    category.save
    expect(Category.first).to eq(category)
  end
    
  it "has many videos" do
    comedies = Category.create(name: "comedies")
    monk = Video.create(title: "Monk", description: "brilliant show")
    futurama = Video.create(title: "Futurama", description: "funny stuff")
    monk.categories << comedies
    futurama.categories << comedies
    expect(comedies.videos).to eq([futurama, monk])
  end
end
