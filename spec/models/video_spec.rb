require 'spec_helper'

describe Video do
 # before(:all) do
    # animated = Category.create(name: 'Animated')
    # pup = Video.create(title: 'Pup', description: 'Good', category: animated) 
    # up = Video.create(title: 'Up', description: 'Good', category: animated) 
    # down = Video.create(title: 'Down', description: 'Bad', category: animated) 
 #  end 
 

    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should belong_to(:category)}

    describe "search_by_title" do
      
      # it "returns an empty array when there are no matches" do
      #   expect(Video.search_by_title('Hello')).to eq([])
      # end

      # it "returns an array of one for a single match " do
      #   animated = Category.create(name: 'Animated')
      #    up = Video.create(title: 'Up', description: 'Good', category: animated) 
      #  expect(Video.search_by_title('Up')).to eq([up])
      # end

# it "returns an array of partial matches " do
#         animated = Category.create(name: 'Animated')
#     pup = Video.create(title: 'Pup', description: 'Good', category: animated) 
#     up = Video.create(title: 'Up', description: 'Good', category: animated) 
#     down = Video.create(title: 'Down', description: 'Bad', category: animated) 
#    expect(Video.search_by_title('Up')).to eq([up,pup])
#       end




      it "orders matches by exactness"
    end

end
