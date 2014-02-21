Fabricator(:review) do
  user_id { Fabricate(:user).id }
  content { Faker::Lorem.paragraphs(2).join('') }
  rating { (1..5).to_a.sample }
end
