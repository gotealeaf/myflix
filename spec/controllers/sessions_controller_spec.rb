require 'spec_helper'

describe SessionsController do

  describe "GET new" do

    it "redirects to home path if user is signed-in" do

    end
    
    it "renders new template" do
      get :new
      expect(response).to render_template :new
    end



  end

  describe "POST create" do

  end

  describe "GET destroy" do

  end


end
