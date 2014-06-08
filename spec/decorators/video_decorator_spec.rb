require 'spec_helper'

describe VideoDecorator do
  it 'should decorate video' do
    video = Fabricate(:video)
    review1 = Fabricate(:review)
    review2 = Fabricate(:review)
    assigns(:video).should be_decorated
  end
end 