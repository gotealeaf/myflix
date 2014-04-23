module Tokenable
  extend ActiveSupport::Concern

  included do
    def generate_token(column)
      self.assign_attributes(column => SecureRandom.urlsafe_base64)
    end
  end

end
