require 'rails_helper.rb'

describe Category do
  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}
end
