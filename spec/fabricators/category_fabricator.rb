Fabricator(:category) do
  name { sequence(:name) {|number| "Category-#{number}"}}
end
