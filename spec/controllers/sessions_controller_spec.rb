require 'spec_helper'

describe SessionsController do

  context "already authenticated user" do
    before { set_current_user }

    describe "GET new" do
      it "redirects to root_path" do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    describe "GET destroy" do
      before { get :destroy }

      it "sets session[:user_id] to nil" do
        expect(session[:user_id]).to be_nil
      end

      it "sets flash msg" do
        expect(flash[:success]).not_to be_blank
      end

      it "redirects to root_path" do
        expect(response).to redirect_to root_path
      end
    end
  end

  context "guest user" do

    describe "GET new" do
      it "renders template :new" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST create" do

      context "valid email and password" do
        let(:current_user) { Fabricate(:user) }
        before { post :create, email: current_user.email , password: current_user.password }

        it "assigns session[:user_id]" do
          expect(session[:user_id]).to eq(current_user.id)
        end
        it "redirects to home page" do
          expect(response).to redirect_to root_path
        end

        it "sets the flash msg" do
          expect(flash[:success]).not_to be_blank
        end
      end

      context "invalid email or password" do
        let(:current_user) { Fabricate(:user) }
        before { post :create, email: current_user.email , password: current_user.password + "abc" }

        it "do not assigns session[:user_id]" do
          expect(session[:user_id]).to be_nil
        end

        it "renders template :new" do
          expect(response).to render_template :new
        end

        it "sets the notice" do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end
  end
end
