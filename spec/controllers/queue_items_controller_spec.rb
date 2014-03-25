require 'spec_helper'

describe QueueItemsController do
  describe "GET #index" do
    context "with unauthenticated user" do
      it "redirects to root_path" do
        get :index
        expect(response).to redirect_to root_path
      end
    end
    context "with authenticated user" do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }
      it "assigns the @queue_items variable" do
        get :index
        expect(assigns(:queue_items)).not_to be_nil
      end 
    end
  end
end