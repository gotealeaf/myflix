require 'spec_helper'

describe SessionsController do

  context "already authenticated user" do
    before { session[:user_id] = Fabricate(:user).id }

    describe "GET new" do
      it "redirect to root_path" do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    describe "GET destroy" do
      before { get :destroy }

      it "set session[:user_id] to nil" do
        expect(session[:user_id]).to be_nil
      end

      it "set flash msg" do
        expect(flash[:success]).not_to be_blank
      end

      it "redirect to root_path" do
        expect(response).to redirect_to root_path
      end
    end
  end

  context "guest user" do

    describe "GET new" do
      it "render template :new" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST create" do

      context "valid email and password" do
        let(:user) { Fabricate(:user) }
        before { post :create, email: user.email , password: user.password }

        it "assign session[:user_id]" do
          expect(session[:user_id]).to eq(user.id)
        end
        it "redirect to home page" do
          expect(response).to redirect_to root_path
        end

        it "set the flash msg" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "invalid email or password" do
        let(:user) { Fabricate(:user) }
        before { post :create, email: user.email , password: user.password + "abc" }

        it "do not assign session[:user_id]" do
          expect(session[:user_id]).to be_nil
        end

        it "render template :new" do
          expect(response).to render_template :new
        end

        it "set the notice" do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end
  end
end
