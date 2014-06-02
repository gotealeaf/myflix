require 'spec_helper'

describe Category do
  it "should save a new category" do
    category = Category.create!(name: 'Action')
    expect(category.name).to eq 'Action'
  end

  it { should have_many(:videos) } 
  it { should validate_presence_of(:name) } 
end
