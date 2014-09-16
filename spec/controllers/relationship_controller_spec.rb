require 'spec_helper'

describe RelationshipsController do

  let(:hank) { Fabricate(:user) }
  let(:joe)  { Fabricate(:user) }


  describe 'GET index' do
    it_behaves_like "require_sign_in" do
      let(:action) {get :index}
    end

    it "prepares the instance variable" do
      set_current_user(hank)
      rel = Relationship.create(follower_id: hank.id, user_id: joe.id)
      get :index
      expect(assigns(:leads)).to eq([rel])
    end
  end

end
