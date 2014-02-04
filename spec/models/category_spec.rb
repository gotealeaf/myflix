require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(title: "Documentaries")
    category.save
    Category.first.title.should == 'Documentaries'
  end
end
