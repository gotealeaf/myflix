module Tokenify
  extend ActiveSupport::Concern


  included do
    before_save :generate_token!
  end


    private

      def generate_token!
        self.token = SecureRandom.urlsafe_base64
      end
end
