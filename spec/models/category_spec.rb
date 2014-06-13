require 'rails_helper'

describe Category do
  
  it "should persist a category to the data store" do
    category = Category.new(name:'Intense Science Fiction')
    category.save
    expect(Category.first).to eq(category)
  end
  
  it "has many videos" do
    sci_fi = Category.create!(name:'Sci-Fi')
    
    alien = Video.create(title:'Alien',
                      description: 'Second best sci-fi movie ever.',
                      category: sci_fi)
    alien.save
    
    the_matrix = Video.create(title:'The Matrix',
                      description: 'The red pill all the way',
                      category: sci_fi)
    the_matrix.save
    
    expect(sci_fi.videos).to eq([alien, the_matrix])
  end
  
end