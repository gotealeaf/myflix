require 'spec_helper'

describe VideosController do
  
  
    describe 'GET #index' do

       before (:each) do
          user = User.create(email: "ex@example.com", full_name: "exe", password: "password")
          #user = Fabricate(:user)
          session[:user_id] = user.id
        end

      it "sets the @videos variable" do
        vids = Fabricate.times(2, :video)
        get :index

        expect(assigns(:videos)).to eq vids
      end

      it "sets the @categories variable" do
        comedy = Category.create(name: "comedy")
        thriller = Category.create(name: "thriller")
        get :index

        expect(assigns(:categories)).to eq [comedy, thriller]
      end

      it "renders index template" do
        get :index
        expect(response).to render_template :index
      end

    end #end index

    describe 'GET #show' do
      
      context "with authenticated users" do
        before (:each) do
          
          session[:user_id] = Fabricate(:user).id
        end
    
        let(:video) {Fabricate(:video)}
        it 'sets @video variable for a requested video' do
          
          get :show, id: video.id

          expect(assigns(:video)).to eq video
        end
        
        it " renders show template" do  #essentially testing rails convention and not our code
          
          get :show, id: video.id
          
          expect(response).to render_template :show
        end
      end #end context

      context "with un-authenticated users" do
        let(:video) {Fabricate(:video)}
        it 'redirects unauthenticated user to root_path' do
          
          get :show, id: video.id
          expect(response).to render_template root_path
          
        end
        
      end #end context

    end #end show

    describe 'GET #search' do
       before (:each) do
          user = User.create(email: "ex@example.com", full_name: "exe", password: "password")
          #user = Fabricate(:user)
          session[:user_id] = user.id
        end
      let(:video) {Video.create(title: "monk", description: "monk description")}
      it "sets @returns variable based on a search term for authenticated users" do
        

        get :search, search_term: "mo"

        expect(assigns(:results)).to eq [video]

      end
      it "returns videos based on partial matches of the search term" do
        chak = Video.create(title: "chak_de", description: "chak de description")
        monk = Video.create(title: "monk", description: "monk description")

        get :search, search_term: "k"

        expect(assigns(:results)).to eq [monk, chak]

      end
    end #end search
  

end