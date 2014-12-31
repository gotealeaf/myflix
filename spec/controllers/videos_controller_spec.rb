require 'rails_helper'

describe VideosController do
  describe 'GET Index' do
    it 'sets the @category attribuendte' do
      sifi = Category.create(name: 'sifi')
      et = Video.create(title: 'et', description: 'lalalalala', categories: [sifi])
      
      get :index
      assigns(:categories).should == [sifi]
    end
    it 'render indext emplate when signed in' do
      usr = User.create(email: '123@123.com', password: '12345')
      login(usr)
      get :index
      response.should render_template :index
    end
    it 'redirect to signup page when not sigied in' do
      get :index
      response.should be_redirect
    end


          
  end  
end