require 'spec_helper'

describe Category do
  context "relationships" do 
    it {should have_many(:videos)}
    it { should_not allow_value(nil).for(:name) }
    it {should allow_value("Batman").for(:name) }
  end 
   
  describe "Category validations" do 

  it "is invalid with no name" do 
    category = Category.create(name: nil)
    expect(category).to_not be_valid
  end 

  it "is valid with a name" do 
    category = Category.create(name: "Batman")
    expect(category).to be_valid
  end  
 end 
end
