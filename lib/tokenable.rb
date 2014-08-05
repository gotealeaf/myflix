module Tokenable
  extend ActiveSupport::Concern

  included do
    after_create :generate_token
  end

  def generate_token
    self.update(token: SecureRandom.urlsafe_base64)
  end
end