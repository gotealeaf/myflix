require 'spec_helper'

describe VideosController do

  context "user logged in" do

      before do
          set_current_user
          @monk = Fabricate(:video)
          @conk = Fabricate(:video)
          @donk = Fabricate(:video)
        end
      
      describe 'GET index' do
        it "prepares the data" do
          get :index
    #index only prepares the category. Videos are gotten in the view
    #puts assigns(:categories).inspect
          assigns(:categories).should == [@monk.category,@conk.category,@donk.category]
        end

        it "renders the template" do
          get :index
          response.should render_template :index
        end

      end

      describe 'GET show' do

        it "prepares the video instance variable" do
          get :show, id: 1
          assigns(:video).should == @monk
        end

        it "prepares the review instance variable for the form" do
          get :show, id: 1
          assigns(:review).should be_a_new(Review)
        end

        it "prepares the reviews instance variable" do
          @review1 = Fabricate(:review, video: @monk)
          @review2 = Fabricate(:review, video: @monk)
          get :show, id: 1
#match array regardless of order
          assigns(:reviews).should =~ [@review1, @review2]
        end

        it "computer the average rating" do
          @review1 = Fabricate(:review, video: @monk)
          @review2 = Fabricate(:review, video: @monk)
          @review3 = Fabricate(:review, video: @monk)
          get :show, id: 1
          
          ratings = assigns(:reviews).map(&:rating)
          mock_ratings = [@review1.rating, @review2.rating, @review3.rating]
          assign_avg =  ratings.inject{ |sum, el| sum + el }.to_f / ratings.size
          mock_avg = mock_ratings.inject{ |sum, el| sum + el }.to_f / mock_ratings.size
          assign_avg.should == mock_avg
          
        end

        it "renders the template" do
          get :show, id: 1
          response.should render_template :show
        end

      end

      describe 'GET search' do

        it "prepares the data" do
          get :search, search_term: @monk.title
          assigns(:videos).should == [@monk]
        end

        it "renders the template" do
          get :search
          response.should render_template :search
        end

      end
  end

  context "user NOT logged in" do
      describe 'GET show' do
        it_behaves_like "require_sign_in" do
          let(:action) {get :show, id: 1}
        end
      end


      describe 'GET search' do
        it_behaves_like "require_sign_in" do
          let(:action) {get :search, search_term: 'monk'}
        end
      end

  end

end
