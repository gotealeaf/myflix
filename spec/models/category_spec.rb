require 'spec_helper'

describe Category do 
  it "saves itself" do
    category = Category.new(name: "Comedy")
    category.save
    expect(Category.first).to eq(category)
  end

  it { should have_many(:video_categories) }
  it { should have_many(:videos).through(:video_categories) }
  
end