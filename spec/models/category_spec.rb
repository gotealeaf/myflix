require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: 'Drama')
    category.save
    expect(Category.first).to eq(category)
  end
  
  it "can have many videos" do
    drama = Category.new(name: 'Drama')
    monk = Video.create(title: 'Monk', description: 'He is not realy a monk', category: drama)
    cheers = Video.create(title: 'Cheers', description: 'There was drama in this sometimes', category: drama)
    expect(drama.videos).to eq([cheers, monk])
  end
  
end
  