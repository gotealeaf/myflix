require 'spec_helper'

describe ForgotPasswordController do

  let(:current_user) { Fabricate(:user) }

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

      before { post :create, email: current_user.email }
      after { ActionMailer::Base.deliveries.clear }

      it "send out a email" do
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end
      it "send to a right user" do
        expect(ActionMailer::Base.deliveries.last.to).to eq([current_user.email])
      end

      it "renders confirmation_password_rest" do
        expect(response).to render_template :confirm_password_reset
      end
    end

    context "with non-existing email input" do

      before { post :create, email: 'abc@example.com' }
      after { ActionMailer::Base.deliveries.clear }

      it "does not send out a email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "redirects to the forgot_password_path" do
        expect(response).to redirect_to forgot_password_path
      end

      it "shows error message" do
        expect(flash[:warning]).not_to be_blank
      end
    end
  end
end
