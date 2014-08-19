require 'spec_helper'

describe Video do
  context "relationships and validations" do 
    it {should belong_to(:category) } 
    it {should_not allow_value(nil).for(:title) } 
    it {should_not allow_value(nil).for(:description) } 
  end 
end 
