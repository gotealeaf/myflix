require 'rails_helper'

describe VideosController do
  describe 'GET Index' do
    it 'sets the @category attribuendte' do
      sifi = Category.create(name: 'sifi')
      et = Video.create(title: 'et', description: 'lalalalala', categories: [sifi])
      
      get :index
      assigns(:categories).should == [sifi]
    end
    
    it 'render the index template' do
          
  end  
end