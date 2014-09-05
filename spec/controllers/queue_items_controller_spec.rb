require 'spec_helper'

describe QueueItemsController do

  context "user logged in" do

    before do
      @rick = Fabricate(:user)
      session[:user_id] = @rick.id
      @monk = Fabricate(:video)
      @conk = Fabricate(:video)
      @q1   = Fabricate(:queue_item, position: 2, user: @rick)
      @q2   = Fabricate(:queue_item, position: 1, user: @rick)
    end

      describe 'GET index' do
        it "prepares the queue items for the current user" do
          get :index
    #puts assigns(:categories).inspect
          assigns(:queue_items).should == [@q2,@q1]
        end

        it "renders the template" do
          get :index
          response.should render_template :index
        end

      end

=begin
    describe 'POST change item order' do
   
      it "updates the queue items orders" do
      end

      it "redirects to queue items" do
      #  response.should redirect_to @monk
      end

      it "sets the notice" do
        flash[:notice].should_not be_blank
      end

    end
=end

  end

  context "user NOT logged in" do

    before do
      @monk = Fabricate(:video)
    end

    describe 'get index' do
      it "renders redirect to sign_in" do
        get :index
        response.should redirect_to sign_in_path
      end
    end

  end

end
