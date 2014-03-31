class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = ["desmonddai583@gmail.com"]
  end
end
