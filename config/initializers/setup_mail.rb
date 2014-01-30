# ActionMailer::Base.smtp_settings = {
#   address:              'smtp.gmail.com',
#   port:                 587,
#   domain:               'gmail.com',
#   user_name:            '46manitoulin@gmail.com',
#   password:             'August19',
#   # user_name:            ENV["GMAIL-USERNAME"],
#   # password:             ENV["GMAIL-PASSWORD"],
#   authentication:       'plain',
#   enable_starttls_auto: true  }


ActionMailer::Base.default_url_options[:host] = "http://http://mvh-myflix.herokuapp.com//"
# ActionMailer::Base.default_url_options[:host] = "localhost:3000"
# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?