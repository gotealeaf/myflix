require 'spec_helper'

describe VideosController do

    before do
      @cartoon = Category.create(name: 'Cartoon')
      @mystery = Category.create(name: 'Mystery')
      @monk = Video.create(title: 'Monk', description: "clever TV show", category: @mystery)
      @conk = Video.create(title: 'Conk', description: "A very conky TV show", category: @mystery)
      @fut = Video.create(title: 'Future Family', description: "Family guy in the future",  category: @cartoon)
    end
  
  describe 'GET index' do
    it "prepares the data" do
      get :index
#index only prepares the category. Videos are gotten in the view
      assigns(:categories).should == [@cartoon,@mystery]
    end

    it "renders the template" do
      get :index
      response.should render_template :index
    end

  end

  describe 'GET show' do

    it "prepares the data" do
      get :show, id: 1
puts "rick assigns  is " + @assigns.inspect
      assigns(:video).should == @monk
    end

    it "renders the template" do
      get :show, id: 1
      response.should render_template :show
    end

  end

  describe 'GET search' do

    it "prepares the data" do
      get :search, search_term: "Monk"
      assigns(:videos).should == [@monk]
    end

    it "renders the template" do
      get :search
      response.should render_template :search
    end

  end


end
