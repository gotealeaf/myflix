require "spec_helper"

describe InvitationsController do
  describe "POST create" do
    context "with an authenticated user" do
      let(:ana) { Fabricate :user }
      before { session[:user_id] = ana.id }
      after { ActionMailer::Base.deliveries.clear }

      context "with valid input" do
        it "redirect to root page" do
          post :create, friend_email: "lucas@toc.com", friend_name: "Paquito"
          expect(response).to redirect_to root_path
        end

        it "sends an email to the friend's address" do
          post :create, friend_email: "lucas@toc.com", friend_name: "Paquito"
          expect(ActionMailer::Base.deliveries.last.to).to eq(["lucas@toc.com"])  
        end

        it "sends an email containing the user name" do
          post :create, friend_email: "lucas@toc.com", friend_name: "Paquito"
          expect(ActionMailer::Base.deliveries.last.body).to include(ana.full_name)        
        end

        it "sends an email containing the friend name" do
          post :create, friend_email: "lucas@toc.com", friend_name: "Paquito"
          expect(ActionMailer::Base.deliveries.last.body).to include("Paquito")              
        end

        it "sends an email with the invitation massage in the content" do
          post :create, friend_email: "lucas@toc.com", friend_name: "Paquito", invitation_message: "Paquito eres muy grande y muy bien."
          expect(ActionMailer::Base.deliveries.last.body).to include("Paquito eres muy grande y muy bien.")     
        end

        it "sets the notice" do
          post :create, friend_email: "lucas@toc.com", friend_name: "Paquito"
          expect(flash[:notice]).to eq("Your invitation has been sent.")
        end
      end

      context "with invalid input" do
        it "renders new template" do
          post :create
          expect(response).to render_template :new      
        end

        it "does not send an email if there is no friend's name submited" do
          post :create, friend_email: "lucas@toc.com"
          expect(ActionMailer::Base.deliveries.last).to be_blank           
        end

        it "does not send an email if there is no friend's email subtimed" do
          post :create, friend_name: "Paquito"
          expect(ActionMailer::Base.deliveries.last).to be_blank   
        end

        it "sets error message" do
          post :create
          expect(flash[:error]).to eq("You have to fill Email and Friend's name fields.")
        end
      end
    end

    context "with an unauthenticated user" do
      it "redirect_to sign in page" do
        post :create, friend_email: "lucas@toc.com", friend_name: "Paquito"
        expect(response).to redirect_to sign_in_path        
      end
    end
  end
end