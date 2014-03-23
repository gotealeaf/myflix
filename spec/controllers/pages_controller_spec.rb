require 'spec_helper'

describe PagesController do

  describe "GET 'front'" do
    it "returns http success" do
      get 'front'
      expect(response).to be_success
    end
  end

end
