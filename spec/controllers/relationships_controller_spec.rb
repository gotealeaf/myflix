require 'spec_helper'

describe RelationshipsController,:type => :controller do
  let(:current_user) { Fabricate(:user) }
  let(:another_user) { Fabricate(:user) }

  describe "POST create" do

    context "with authenticated user" do

      context "with valid input" do
        before do
          session[:user_id] = current_user.id
          post :create, id: another_user.id
        end
        it "creates a relationship" do
          expect(current_user.following?(another_user.id)).to be true
        end

        it "assoicates with current_user" do
          expect(current_user.followed_users.first).to eq(another_user)
        end

        it "set flash message" do
          expect(flash[:success]).not_to be_blank
        end
        it "redirects to following_people_path" do
          expect(response).to redirect_to following_people_path
        end
      end

      context "with invalid input" do
        before do
          session[:user_id] = current_user.id
          post :create, id: current_user.id
        end

        it "does not create a relationship" do
          expect(Relationship.count).to be(0)
        end
        it "set flash message" do
          expect(flash[:warning]).not_to be_blank
        end

        it "redirects to following_people_path" do
          expect(response).to redirect_to following_people_path
        end

      end
    end
    context "with unauthenticated user" do
      it "redirects to signin_path" do
        post :create, followed_id: 1, follower_id: 2
        expect(response).to redirect_to signin_path
      end
    end

  end

  describe "DELETE destory" do

    context "with authenticated user" do

      before do
        session[:user_id] = current_user.id
        Fabricate(:relationship, follower: current_user, followed: another_user)
        delete :destroy, id: another_user.id
      end

      it "delete the relationship" do
        expect(current_user.following?(another_user.id)).to be false
      end

      it "set flash message" do
        expect(flash[:success]).not_to be_blank
      end

      it "redirects to following_people_path" do
        expect(response).to redirect_to following_people_path
      end
    end
    context "with unauthenticated user" do
      it "redirects to signin_path" do
        delete :destroy, id: 1
        expect(response).to redirect_to signin_path
      end
    end
  end
end
