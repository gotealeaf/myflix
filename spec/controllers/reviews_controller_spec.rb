require 'rails_helper'

describe ReviewsController do
  describe 'POST Create' do
    it 'should create the review successfuly when enter valid reviews' do
      video = Video.create(title: 'et', description: 'lalalala')
      post :create, video_id: 1, review:{ rating: '1', body: "i don't like it "}
      response.should redirect_to video_path(video)

    end

    it 'should render video show template when enter empty reviews' do
      video = Video.create(title: 'et', description: 'lalalala')
      post :create, video_id: 1, review:{ rating: '1', body: ""}
      response.should render_template 'videos/show'
    end
  end
end