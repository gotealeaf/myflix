require 'spec_helper'
require 'shoulda/matchers'

describe Category do
  it { should have_many :videos }
end
  # Simplify by shoulda_matchers above

  # it "has many videos" do
  #   soaps = Category.create(name: "Soaps")
  #   batman = Video.create(title: "Batman", description: "Gotham needs a hero.", category: soaps)
  #   superman = Video.create(title: "Superman", description: "Metropolis needs a hero.", category: soaps)
  #   expect(soaps.videos).to eq([batman, superman])
  # end

  # We don't need below any more

  # it "saves itself" do
  #   category = Category.new(name: "Soap")
  #   category.save
  #   expect(Category.last).to eq(category)
  # end