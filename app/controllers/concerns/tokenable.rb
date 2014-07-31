module Tokenable
  extend ActiveSupport::Concern

  def generate_token(user)
    UserToken.create(token: SecureRandom.urlsafe_base64, user: user)
  end
end
