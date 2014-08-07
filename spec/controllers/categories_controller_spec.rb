require 'spec_helper'

describe CategoriesController do
  let(:action) { Fabricate(:category) }

  describe "GET show" do
    it "assigns @category" do
      get :show, id: action.id
      expect(assigns(:category)).to eq (action)
    end

    it "renders show tmplate" do
      get :show, id: action.id
      expect(response).to render_template :show
    end
  end
end
