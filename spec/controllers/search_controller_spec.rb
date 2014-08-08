require 'spec_helper'

describe SearchController do

  describe "GET index" do

    let!(:video) { Fabricate(:video, title: "Guardians Of The Galaxy") }
    before { 100.times { Fabricate(:video) } }

    context "exact match" do
      before { get :index, search: "Guardians of the Galaxy" }

      it "redirects to video" do
        expect(response).to redirect_to video
      end
    end

    context "exact match with case insensitive" do
      before { get :index, search: "guardians of the galaxy" }

      it "redirects to video" do
        expect(response).to redirect_to video
      end
    end

    context "partly match" do
      before { get :index, search: "Guardians" }

      it "assigns @videos" do
        expect(assigns(:results)).to include(video)
      end

      it "renders template :index" do
        expect(response).to render_template :index
      end
    end

    context "unmatch" do

      before { get :index, search: "safd" }

      it "assigns @result as empty" do
        expect(assigns(:results)).to eq([])
      end

      it "renders template :index" do
        expect(response).to render_template :index
      end
    end
  end

end
