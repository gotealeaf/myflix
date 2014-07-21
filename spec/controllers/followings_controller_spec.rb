require "spec_helper"

describe FollowingsController do
  describe "GET index" do
    context "with authenticated user" do
      it "sets the @following variable" do
        set_current_user
        jimbo = Fabricate(:user)
        following = Fabricate(:following, user_id: current_user.id, followed_user_id: jimbo.id)
        get :index
        expect(assigns(:followings)).to eq(current_user.followings)
      end
    end
    
    it_behaves_like "require_login" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    context "with authenticated user" do
      before { set_current_user }

      context "when the current user is not already following the new user" do
        let(:mike) { Fabricate(:user) }
        before { post :create, followed_user_id: mike.id }

        it "it adds a new user to the list of people the current user is following" do
          expect(current_user.followed_users).to eq([mike])
        end

        it "renders the :index template" do
          expect(response).to render_template :index
        end
      end

      context "when the current user is already following the new user" do
        it "redirects to the people page" do
          sarah = Fabricate(:user)
          following = Fabricate(:following, user_id: current_user.id, followed_user_id: sarah.id)
          post :create, followed_user_id: sarah.id
          expect(response).to redirect_to people_path
        end
      end
    end

    it_behaves_like "require_login" do
      let(:action) { post :create, followed_user_id: 1 }
    end
  end

  describe "DELETE destroy" do
    context "with authenticated user" do
      let(:sarah) { Fabricate(:user) }

      before do 
        set_current_user
        following = Fabricate(:following, user_id: current_user.id, followed_user_id: sarah.id)
        delete :destroy, id: following.id
      end  

      it "deletes the followed user" do
        expect(current_user.followed_users.count).to eq(0)
      end

      it "redirects to people page" do
        expect(response).to redirect_to people_path
      end

      it "does not delete followed user if they for another user" do
        following2 = Fabricate(:following, user_id: sarah.id, followed_user_id: current_user.id)        
        delete :destroy, id: following2.id
        expect(sarah.followed_users.count).to eq(1)
      end
    end

    it_behaves_like "require_login" do
      let(:action) { delete :destroy, id: 1 }
    end
  end
end









