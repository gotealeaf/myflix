require 'spec_helper'

describe RelationshipsController do

  describe "POST create" do
    let(:joe) { Fabricate(:user)  }
    let(:jen) { Fabricate(:user)  }
    before do
      sign_in_user(joe)
      post :create, { user_id: jen }
    end

    it "loads the '@user' instance variable with the desired information" do
      expect(assigns(:user)).to eq(jen)
    end
    it "creates the friend relationship to the clicked user" do
      expect(joe.leaders.first).to eq(jen)
    end
    it "flashes a notice of success for successful relationship creation" do
      expect(flash[:notice]).to_not be_nil
    end
    it "flashes an error if the relationship is not able to be made" do
      expect(flash[:notice]).to_not be_nil
    end
    it "redirects to the relationships#index page" do
      expect(response).to redirect_to people_path
    end
    it "does not allow users to follow themselves" do
      expect {post :create, { user_id: joe.id }}.to_not change(Relationship, :count)
    end

    context "for an unauthenticated user" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) { post :create, user_id: 3 }
      end
    end
  end


  describe "GET index" do
    let(:joe) { Fabricate(:user)  }
    let(:jen) { Fabricate(:user)  }

    before do
      sign_in_user(joe)
      joe.following_relationships.create(leader: jen)
      get :index
    end

    it "sets the followed leaders of the current_user into the @leaders instance variable" do
      expect(assigns(:leaders)).to eq([jen])
    end

    context "for an unauthenticated user" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) { get :index }
      end
    end
  end

  describe "DELETE destroy" do
    let(:joe) { Fabricate(:user)  }
    let(:jen) { Fabricate(:user)  }

    before do
      sign_in_user(joe)
      joe.following_relationships.create(leader: jen)
      delete :destroy, { leader_id: jen.id }
    end

    it "removes the leader from the list of people the user follows" do
      expect(joe.leaders).to be_empty
    end
    it "loads the relationship local variable with the relationship to destroy" do
      expect(assigns(:relationship)).to eq(joe.following_relationships.all.first)
    end
    it "loads the leader local variable with the user-leader of relationship being destroyed" do
      expect(assigns(:leader)).to eq(jen)
    end
    it "flashes a notice saying that the user was removed from people followed" do
      expect(flash[:notice]).to_not be_nil
    end
    it "flashes an error if followed person could not be removed" do
      delete :destroy, { leader_id: 5 }
      expect(flash[:error]).to_not be_nil
    end

    context "for an unauthenticated user" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) { delete :destroy, leader_id: 3 }
      end
    end
  end
end


