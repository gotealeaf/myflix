require 'spec_helper'

describe InvitationsController do
  describe "Get new" do
    it "sets @invitation to a new invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of(Invitation)
    end


    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end

 describe "POST create" do
  it_behaves_like "requires sign in" do
    let(:action) { post :create }
 end

 context "with valid input" do
  before :each do
    set_current_user
  end

  after { ActionMailer::Base.deliveries.clear }

  it "redirects to the invitation new page" do
    post :create, invitation: { recipient_name: "Mark Hustad", recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
    expect(response).to redirect_to new_invitation_path
  end

  it "creates an invitation" do
    post :create, invitation: { recipient_name: "Mark Hustad", recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
    expect(Invitation.count).to eq(1)
  end

  it "sends an email to the recipient" do
    post :create, invitation: { recipient_name: "Mark Hustad", recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
    expect(ActionMailer::Base.deliveries.last.to).to eq(['mark@hotmail.com'])
  end
  
  it "sets the flash success message" do
    post :create, invitation: { recipient_name: "Mark Hustad", recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
    expect(flash[:success]).to be_present
  end
 end


  context "with invalid input" do
    before :each do
      set_current_user
    end
    
    after { ActionMailer::Base.deliveries.clear }
  
  it "renders the :new template" do
    post :create, invitation: { recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
    expect(response).to render_template :new
  end
    
  it "does not create an invitation" do
    post :create, invitation: { recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
    expect(Invitation.count).to eq(0)
  end
    
  it "does not send out an email" do 
    post :create, invitation: { recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
    expect(ActionMailer::Base.deliveries).to be_empty
  end
  end
    
    it "sets the flash error message" do
      set_current_user
    post :create, invitation: { recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
      expect(flash[:error]).to be_present
    end

    
    it "sets @invitation" do
      set_current_user
    post :create, invitation: { recipient_email: "mark@hotmail.com", message: "Hey, try Myflix" }
      expect(assigns(:invitation)).to be_present
    end
 end
end