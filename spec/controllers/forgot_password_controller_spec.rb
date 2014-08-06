require 'spec_helper'

describe ForgotPasswordController do
  describe "POST create" do
    context "with blank input" do
      before { post :create, email: '' }

      it "redirects to the forgot_password_path" do
        expect(response).to redirect_to forgot_password_path
      end

      it "shows error message" do
        expect(flash[:warning]).not_to be_blank
      end
    end

    context "with exisiting email input" do

    end

    context "with non-existing email input" do


    end

  end
end
