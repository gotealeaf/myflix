require 'spec_helper'

describe PagesController do

  describe "GET 'front'" do
    it "returns http success" do
      get 'front'
      response.should be_success
    end
  end

end
