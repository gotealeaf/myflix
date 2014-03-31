ActionMailer::Base.register_interceptor(SandboxEmailInterceptor) if Rails.env.staging?
