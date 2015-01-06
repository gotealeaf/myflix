require 'rails_helper'

describe VideosController do
  let(:user) { Fabricate(:user)}

  describe 'GET Index' do    
    context 'logged in' do
      before { login(user) }
      it 'sets the @category attribute when logged in'  do
        sifi = Category.create(name: 'sifi')
        et = Video.create(title: 'et', description: 'lalalalala', categories: [sifi])              
        get :index
        assigns(:categories).should == [sifi]
      end
      it 'render index template when signed in' do
        get :index
        response.should render_template :index
      end  
    end    
    it 'redirect to signup page when not sigied in' do
      get :index
      response.should be_redirect
    end              
  end  

  describe 'GET Show' do  
    let!(:et) { Fabricate(:video) } # eager loading by using !
    context 'logged in' do      
      before {login(user)}             
      it 'should set the @video attribute' do              
        get :show, id: '1'
        assigns(:video).should == et
      end
      it 'should render show template when logged in' do          
        get :show, id: '1'
        response.should render_template :show      
      end  
    end
    
    it 'should redirect to front page if not logged in' do            
      get :show, id: '1'
      response.should be_redirect
    end
  end

  describe 'GET Search' do
    let!(:et) { Fabricate(:video) }

    context 'logged in' do
      before { login(user) }
      it 'should set the results attribute correctly' do             
        get :search, query: 'e'
        assigns(:results).should == [et]
      end
      it 'should render the search template when logged in' do       
        get :search, query: 'e'
        response.should render_template :search
      end
    end    

    it 'should redirect when not logged in' do
      get :search, query: 'e'
      response.should be_redirect
    end
  end
end