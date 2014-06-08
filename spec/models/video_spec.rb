require 'rails_helper.rb'

# shoulda gem syntax
describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
end
