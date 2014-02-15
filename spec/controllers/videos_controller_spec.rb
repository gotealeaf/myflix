require 'spec_helper'
require 'pry'

describe VideosController do

  describe 'GET #show' do
    it 'sets the @video object correctly' do
      simpsons = Video.create(title: 'The Simpsons!', description: 'A family that loves living together.')
      futurama = Video.create(title: 'Futurama!', description: 'This is a crazy place where people live in the future.')
      get :show, id: futurama.id.to_s
      expect(assigns(:video)).to eq futurama
    end

    it 'renders the :show template'
  end
end
