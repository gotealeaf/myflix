require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it 'saves itself' do
    monk = Video.new(title: 'monk', description: 'n/a')
    monk.save
    expect(Video.first).to eq(monk)
  end
  
  it 'does not save a video without a title' do
    south_park = Video.new(description: 'n/a')
    south_park.save
    expect(Video.all.size).to eq(0)
    #so, each it...do block is seperate from each other? otherwise how come this could be 0 as we just created a video sucessfully in the 'saves itself' block above
  end
  
  it 'belongs to category' do
    tv = Category.create(name: 'TV')
    monk = Video.create(title: 'Monk', description: 'n/a', category: tv)
    expect(monk.category).to eq(tv)
  end
end
