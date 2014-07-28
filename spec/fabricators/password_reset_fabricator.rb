Fabricator(:password_reset) do
  token { SecureRandom.urlsafe_base64 }
end
