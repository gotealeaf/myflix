# Load the rails application
require File.expand_path('../application', __FILE__)

DATABASE_OPERATOR = {
  like_operator: 'LIKE'
}

# Initialize the rails application
Myflix::Application.initialize!
