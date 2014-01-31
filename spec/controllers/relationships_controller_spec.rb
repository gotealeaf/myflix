require 'spec_helper'

describe RelationshipsController do
  describe 'GET index' do
    it "sets @Relationships to the current user's following relationships" do
      sam = Fabricate(:user)
      set_current_user(sam)
      vivian = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: sam, leader: vivian)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
  end
end
