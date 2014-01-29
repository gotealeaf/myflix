require 'faker'

Fabricator(:category) do 
  name { Faker::Name.name }
end