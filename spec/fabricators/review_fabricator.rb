Fabricator(:review) do
  rate { (1..5).to_a.sample }
  review { Faker::Lorem.paragraph(3).to_s }
end
