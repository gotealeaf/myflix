require "spec_helper"

describe UsersController do
  describe "GET new" do
    before { get :new }

    it "assigns a new User to @user" do
      expect(assigns(:user)).to be_a_new(User) 
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }
          
      it "saves new user to the database" do
        expect(User.count).to eq(1)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end

      it "assigns @user variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "sets notice" do
        expect(flash[:notice]).to_not be_blank
      end

      it "puts the user in the session" do
        expect(session[:user_id]).to eq(User.first.id)
      end

      context "sending email" do
        it "sends out the email" do
          expect(ActionMailer::Base.deliveries).to_not be_empty
        end

        it "sends email the correct recipient" do
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([User.first.email])
        end

        it "sends email with the correct message" do
           message = ActionMailer::Base.deliveries.last
           expect(message.body).to include(User.first.fullname)
        end
      end
    end

    context "without valid input" do
      before { post :create, user: { fullname: nil, email: nil, password: nil } }
    
      it "does not save new user to the database" do
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        expect(response).to render_template  :new
      end
    end  
  end

  describe "GET show" do
    context "with authenticated user" do
      before do
       set_current_user
       get :show, id: current_user.id
      end

      it "sets the @user variable" do
        expect(assigns(:user)).to eq(current_user)
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end

    let(:jimbo) { Fabricate(:user) }

    it_behaves_like "require_login" do
      let(:action) { get :show, id: jimbo.id }
    end
  end

end





