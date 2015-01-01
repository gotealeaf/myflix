require 'rails_helper'

describe VideosController do
  describe 'GET Index' do
    it 'sets the @category attribute when logged in'  do
      sifi = Category.create(name: 'sifi')
      et = Video.create(title: 'et', description: 'lalalalala', categories: [sifi])
      usr = User.create(email: '123@123.com', password: '12345')
      login(usr)
      
      get :index
      assigns(:categories).should == [sifi]
    end
    it 'render index template when signed in' do
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
  describe 'GET Show' do
    it 'should set the @video attribute' do
      usr = User.create(email: '123@123.com', password: '12345')
      login(usr)
      et = Video.create(title: 'et', description: 'lalalalala') 
      get :show, id: '1'
      assigns(:video).should == et
    end
    it 'should render show template when logged in' do
      usr = User.create(email: '123@123.com', password: '12345')
      login(usr)
      et = Video.create(title: 'et', description: 'lalalalala') 
      get :show, id: '1'
      response.should render_template :show
    end

    it 'should redirect to front page if not logged in' do
      et = Video.create(title: 'et', description: 'lalalalala') 
      get :show, id: '1'
      response.should be_redirect
    end
  end
end