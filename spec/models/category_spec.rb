require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(title: "Documentaries")
    category.save
    expect(Category.first).to eq(category)
  end
end
