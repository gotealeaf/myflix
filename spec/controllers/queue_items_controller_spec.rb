require "spec_helper"

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated user" do

      it "displays all of the videos in the users queue" do
        joe = Fabricate(:user)
        session[:user_id] = joe.id
        queue_item1 = Fabricate(:queue_item, user: joe)
        queue_item2 = Fabricate(:queue_item, user: joe)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end

      it "renders the :index template" do
        joe = Fabricate(:user)
        session[:user_id] = joe.id
        get :index
        expect(response).to render_template :index
      end
    end
    context "with unauthenticated user" do
      it "redirects to login page"
    end
  end
end