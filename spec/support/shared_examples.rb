shared_examples "requires sign in" do
	it "redirects to the sign in page" do
		session[:user_id] = nil
		action
		expect(response).to redirect_to sign_in_path
	end
end

shared_examples "requires admin" do
	it "redirects to the root path" do
		session[:user_id] = Fabricate(:user)
		action
		expect(response).to redirect_to root_path
	end
end

shared_examples "tokenable" do
	it "generates a random token when user is created" do
		expect(object.token).to be_present
	end
end