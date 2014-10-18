require 'spec_Helper'

describe UsersController do	

	describe "GET new" do
		it "assigns user to new instance of User" do
			get :new
			expect(assigns(:user)).to be_a_new(User)
		end
	end

	describe "POST create" do

		context 'with valid input' do

			it 'creates a new user' do
				post :create, user: {email: "test@test.com", fullname: "tester", password: "testtest"}
				expect(User.count).to eq(1)
			end

			it 'redirects to sign_in path' do
				post :create, user: {email: "test@test.com", fullname: "tester", password: "testtest"}
				expect(response).to redirect_to signin_path
			end

		end

		context 'with invalid input' do

			it 'does not create a new user' do
				post :create, user: {email: "test@test.com"}
				expect(User.count).to eq(0)
			end

			it 'renders new template' do
				post :create, user: {email: "test@test.com"}
				expect(response).to render_template(:new)
			end

			it 'assigns a user object' do
				post :create, user: {email: "test@test.com"}
				expect(assigns(:user)).to be_instance_of(User)
			end
		end

	end
end




=begin

	def new
		@user = User.new
	end

	def create
		@user = User.new(userparams)
		if @user.save
			flash[:notice] = "You have successfully registered"
			redirect_to signin_path
		else
			render 'new'
		end
	end

	private

	def userparams
		params.require(:user).permit!
	end
=end