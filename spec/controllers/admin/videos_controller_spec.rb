require 'spec_helper'

describe Admin::VideosController do
  
  describe "GET new" do
    it "sets the @video instance variable" do
      set_admin
      get :new
      expect(assigns(:video)).to be_instance_of(Video)
      expect(assigns(:video)).to be_new_record
    end
    
    it_behaves_like 'require admin' do
      let(:action) { get :new }
    end
    
    it "displays a flash message" do
      set_current_user
      get :new
      expect(flash[:danger]).not_to be_blank
    end
    
    it_behaves_like "require sign in" do
      let(:action) {get :new}
    end
  end # ends the GET new test
  
  describe "POST create" do
    
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end
    
    it_behaves_like "require admin" do
      let(:action) { post :create }
    end
    
    context "valid input" do
      
      let(:category1) { Fabricate(:category, name: "Drama") }
      let(:category2) { Fabricate(:category, name: "Action") }
      
      before do
        set_admin
        post :create, video: {description: "Funny as hell!", title: "Monk 2", category_ids: [category1.id, category2.id]}
      end
      
      it 'adds a video' do
        expect(Video.count).to eq(1)
        expect(category1.videos.count).to eq(1)
      end
      
      it 'redirects to the add video path' do
        expect(response).to redirect_to new_admin_video_path
      end
      
      it 'displays a success flash message' do
        expect(flash[:success]).not_to be_blank
      end
      
    end #ends valid input context
    
    context "invalid input" do
      
      before do
        set_admin
        post :create, video: {description: "Funny as hell!"}
      end
      
      it 'does not add a video' do
        expect(Video.count).to eq(0)
      end
      
      it 'displays a flash error message' do
        expect(flash[:danger]).not_to be_blank
      end
      
      it 'sets the @video instance variable' do
        expect(assigns(:video)).to be_instance_of(Video)
      end
      
      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end #ends invalid input context
    
  end #ends POST create test
end