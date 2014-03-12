require 'spec_helper'

describe UsersController do
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create', user: { email: "john@example.com", password: "password", full_name: "John Wu" }
      response.should redirect_to(sign_in_path)
    end
  end
end
