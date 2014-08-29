require 'spec_helper'

describe VideosController do

  describe 'GET index' do
    before do
      @cartoon = Category.create(name: 'Cartoon')
      @mystery = Category.create(name: 'Mystery')
      monk = Video.create(title: 'Monk', description: "clever TV show", category: @mystery)
      conk = Video.create(title: 'Conk', description: "A very conky TV show", category: @mystery)
      fut = Video.create(title: 'Future Family', description: "Family guy in the future",  category: @cartoon)
    end
  
    it "prepares the data" do
      get :index
#puts "rick assigns  is " + @assigns.inspect
      assigns(:categories).should == [@cartoon,@mystery]
    end

    it "renders the template" do
      get :index
      response.should render_template :index
    end

  end


  describe 'GET search' do
    before do
      @cartoon = Category.create(name: 'Cartoon')
      @mystery = Category.create(name: 'Mystery')
      @monk = Video.create(title: 'Monk', description: "clever TV show", category: @mystery)
      conk = Video.create(title: 'Conk', description: "A very conky TV show", category: @mystery)
      fut = Video.create(title: 'Future Family', description: "Family guy in the future",  category: @cartoon)
    end

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
