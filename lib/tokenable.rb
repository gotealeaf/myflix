module Tokenable
  extend ActiveSupport::Concern

  included do
    def generate_token(column)
      column = SecureRandom.urlsafe_base64
    end
  end

end
