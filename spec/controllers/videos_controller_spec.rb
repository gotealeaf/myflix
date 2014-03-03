require 'spec_helper'
# show
# search

describe VideosController do 
  describe "GET show" do
    it "sets the @video variable" do
      south_park = Fabricate(:video)

      get :show
      expect(assigns(:videos)).to eq(south_park)
    end

    it "renders the show template"
  end
end