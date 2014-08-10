require 'spec_helper'

describe Category do

  it "saves itself" do
    category = Category.new(name: "Thrillers")
    category.save
    expect(Category.first).to eql(category)

  end
end
