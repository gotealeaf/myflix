require 'spec_helper'

describe VideosController do 
  describe "GET show" do
    it "sets the @video variable" do
      south_park = Fabricate(:video)

      get :show, id: '1'
      expect(assigns(:videos)).to eq(south_park)
    end

    it "renders the show template"
  end
end